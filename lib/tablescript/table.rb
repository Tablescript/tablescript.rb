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
    attr_reader :entries

    def initialize(name, roller)
      @name = name
      @roller = roller
      @entries = nil
    end

    def build(&blk)
      @entries = TableEntryEnvironment.new(@name, @roller)
      @entries.instance_eval(&blk)
    end

    def random_entry
      @roller.rollD(@entries.die_to_roll)
    end

    def lookup(index)
      @entries.lookup(index)
    end

    def roll
      @entries.reroll
    end

    def roll_and_ignore_duplicates(times, args)
      @entries.reroll_and_ignore_duplicates(times, args)
    end
  end
end
