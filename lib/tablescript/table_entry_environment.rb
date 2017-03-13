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
  # TableEntryEnvironment
  #
  class TableEntryEnvironment
    def initialize(roll, table)
      @roll = roll
      @table = table
    end

    def roll
      @roll
    end

    def table_name
      @table.name
    end

    def dice_to_roll
      @table.dice_to_roll
    end

    def lookup(roll)
      @table.lookup(roll).evaluate(roll)
    end

    def reroll
      rolled_value = @roller.roll(dice_to_roll)
      lookup(rolled_value)
    end

    def reroll_and_ignore(*args)
      validate_ignored_values(args)
      rolled_value = @roller.roll_and_ignore(dice_to_roll, args)
      lookup(rolled_value)
    end

    def reroll_and_ignore_duplicates(times, *args)
      ignored_entries = entries_from_ignored_values(args)
      evaluated_rolled_entries = []
      until evaluated_rolled_entries.size == times do
        rolled_value = @roller.roll(dice_to_roll)
        rolled_entry = @entries[rolled_value - 1]
        unless ignored_entries.include? rolled_entry
          ignored_entries << rolled_entry
          evaluated_rolled_entries << rolled_entry.evaluate(rolled_value)
        end
      end
      evaluated_rolled_entries
    end

    def method_missing(method_id)
      raise "Undefined command '#{method_id}' in table #{@table.name}"
    end

    private

    def entries_from_ignored_values(args)
      entries = []
      args.each do |arg|
        if arg.is_a?(Integer)
          entries << lookup(arg)
        elsif arg.class == Range
          arg.each do
            entries << lookup(arg)
          end
        end
      end
      entries.uniq
    end

    def validate_ignored_values(args)
      raise 'No ignored values specified' if args.empty?
    end
  end
end
