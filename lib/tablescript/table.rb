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

    def initialize(name, roller)
      @name = name
      @roller = roller
      @entries = []
    end

    def add_entry(entry)
      @entries << entry
    end

    def set_entry(roll, entry)
      raise "Duplicate entry for #{roll} in table #{@name}" unless @entries[roll - 1].nil?
      @entries[roll - 1] = entry
    end

    def dice_to_roll
      "d#{@entries.size}"
    end

    def lookup(roll)
      @entries[roll - 1]
    end

    def roll
      rolled_value = dice_to_roll.roll
      lookup(rolled_value).evaluate(rolled_value)
    end

    def roll_and_ignore_duplicates(times, args)
      @entries.reroll_and_ignore_duplicates(times, args)
    end
  end
end
