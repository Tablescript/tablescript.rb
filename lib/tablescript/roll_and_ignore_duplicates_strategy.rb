# Copyright 2017 Jamie Hale
#
# This file is part of the Tablescript gem.
#
# Tablescript is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Tablescript is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Tablescript.  If not, see <http://www.gnu.org/licenses/>.

module Tablescript
  ##
  # RollAndIgnoreDuplicatesStrategy
  #
  class RollAndIgnoreDuplicatesStrategy
    def initialize(table, roll_count, ignore = nil)
      @table = table
      @roll_count = roll_count
      @roll_history = ignore || RpgLib::RollSet.new
      @entry_ids = Set.new
      @rolls = []
      @values = []
    end

    def rolls
      evaluate
      @rolls
    end

    def values
      evaluate
      @values
    end

    private

    def evaluate
      loop do
        roll_next_value
        break if @values.size == @roll_count
      end
    end

    def roll_next_value
      roll = next_roll(@table.dice_to_roll)
      entry = @table.lookup(roll)
      return if @entry_ids.include?(entry.id)
      record(roll, entry)
    end

    def record(roll, entry)
      @entry_ids.add(entry.id)
      @roll_history.add(entry.roll)
      @rolls << roll
      @values << entry.evaluate(roll, @table)
    end

    def next_roll(dice)
      RpgLib::DiceRoller.instance.roll_and_ignore(dice, @roll_history)
    end
  end
end
