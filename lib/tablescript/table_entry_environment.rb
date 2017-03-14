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
    attr_reader :roll

    def initialize(roll, table)
      @roll = roll
      @table = table
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
      @table.roll
    end

    def reroll_and_ignore(*args)
      validate_ignored_values(args)
      @table.roll_and_ignore_values(RollSet.new(*args))
    end

    def reroll_and_ignore_duplicates(times, *args)
      @table.roll_and_ignore_duplicates(times, *args)
    end

    private

    def validate_ignored_values(args)
      raise 'No ignored values specified' if args.empty?
    end
  end
end
