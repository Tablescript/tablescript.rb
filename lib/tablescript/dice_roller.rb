# Copyright 2015 Jamie Hale
#
# This file is part of the Tablescript gem.
#
# Tablescript.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Tablescript.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Tablescript.  If not, see <http://www.gnu.org/licenses/>.

module Tablescript
  ##
  # DiceRoller
  #
  class DiceRoller
    @@DICE_REGEXP = /(\d*)d(\d+)((dl)(\d*)|(dh)(\d*))?/

    def random_value_in_range(range)
      rand(range)
    end

    def roll_dice(roll_descriptor)
      rolled_values = roll_all_dice_from_descriptor(roll_descriptor)
      drop_lowest(rolled_values, roll_descriptor)
      drop_highest(rolled_values, roll_descriptor)
      total(rolled_values)
    end

    def roll(dice)
      while m = dice.downcase.match(@@DICE_REGEXP) do
        rolled_value = roll_dice(RollDescriptor.new(m))
        dice[m.begin(0)...m.end(0)] = rolled_value.to_s
      end
      eval(dice)
    end

    def roll_and_ignore(dice, args)
      ignored_values = collect_ignored_values(args)
      rolled_value = nil
      while rolled_value.nil? do
        rolled_value = roll(dice)
        rolled_value = nil if ignored_values.include? rolled_value
      end
      rolled_value
    end

    private

    def roll_all_dice_from_descriptor(roll_descriptor)
      rolled_values = []
      1.upto roll_descriptor.count do
        rolled_values << random_value_in_range(1..roll_descriptor.die)
      end
      rolled_values.sort
    end

    def drop_lowest(rolled_values, roll_descriptor)
      rolled_values.slice!(0, roll_descriptor.drop_lowest)
    end

    def drop_highest(rolled_values, roll_descriptor)
      rolled_values.slice!(rolled_values.size - roll_descriptor.drop_highest, roll_descriptor.drop_highest)
    end

    def total(rolled_values)
      rolled_values.inject(:+)
    end

    def collect_ignored_values(args)
      ignored_values = []
      until args.empty? do
        value = args.shift
        if value.is_a?(Integer)
          ignored_values << value
        elsif value.class == Range
          value.each do |i|
            ignored_values << i
          end
        end
      end
      ignored_values.uniq
    end
  end
end
