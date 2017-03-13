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
  # Table
  #
  class Table
    attr_reader :name, :entries

    def initialize(name, entries)
      @name = name
      @entries = entries
    end

    def dice_to_roll
      "d#{@entries.size}"
    end

    def lookup(roll)
      @entries[roll - 1]
    end

    def roll
      rolled_value = dice_to_roll.roll
      lookup(rolled_value).evaluate(rolled_value, self)
    end

    def roll_and_ignore(rollset)
      rolled_value = dice_to_roll.roll_and_ignore(rollset)
      lookup(rolled_value).evaluate(rolled_value, self)
    end

    def roll_and_ignore_duplicates(times)
      entries = Set.new
      rolls = RollSet.new
      results = []
      loop do
        roll = dice_to_roll.roll_and_ignore(rolls)
        entry = lookup(roll)
        unless entries.include?(entry.id)
          entries.add(entry.id) # record entry
          rolls.add(entry.roll) # record roll
          results << entry.evaluate(roll, self)
          break if results.size == times
        end
      end
      results
    end
  end
end
