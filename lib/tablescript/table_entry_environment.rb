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
  # TableEntryEnvironment
  #
  class TableEntryEnvironment
    def initialize(roll, table, entry)
      @roll = roll
      @table = table
      @entry = entry
    end

    def context
      RollContext.new(@roll, @table, @entry)
    end

    def lookup(roll)
      @table.lookup(roll).evaluate(roll)
    end

    def roll_on(path)
      RollStrategy.new(resolve(path)).value
    end

    def roll_on_and_ignore(path, *args)
      RollAndIgnoreStrategy.new(resolve(path), RpgLib::RollSet.new(*args)).value
    end

    def roll_on_and_ignore_duplicates(path, times)
      RollAndIgnoreDuplicatesStrategy.new(resolve(path), times).value
    end

    def lookup_on(path, roll)
      LookupStrategy.new(resolve(path), roll).value
    end

    def reroll
      RollStrategy.new(@table).value
    end

    def reroll_and_ignore(*args)
      RollAndIgnoreStrategy.new(@table, RpgLib::RollSet.new(*args)).value
    end

    def reroll_and_ignore_duplicates(times)
      RollAndIgnoreDuplicatesStrategy.new(@table, times, RpgLib::RollSet.new(@entry.roll)).values
    end

    private

    def resolve(path)
      namespace = @table.namespace
      until namespace.nil?
        return namespace.resolve(path) if namespace.resolve?(path)
        namespace = namespace.parent
      end
      raise Exception, "No such table #{path}"
    end
  end
end
