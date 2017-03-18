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
  # Table
  #
  class Table
    attr_reader :name, :entries

    def initialize(name, namespace, &blk)
      @name = name
      @namespace = namespace
      @entries = TableEntries.new
      instance_eval(&blk)
    end

    def f(roll = nil, &blk)
      @entries.add_fixed(roll, &blk)
    end

    def d(count = 1, &blk)
      @entries.add_dynamic(count, &blk)
    end

    def lookup(roll)
      @entries.lookup(roll).evaluate(roll, self)
    end

    def lookup_on(path, roll)
      LookupStrategy.new(resolve(path.to_s), roll).value
    end

    def dice_to_roll
      "d#{@entries.size}"
    end

    def roll_on(path)
      RollStrategy.new(resolve(path.to_s)).value
    end

    def roll_on_and_ignore(path, *args)
      RollAndIgnoreStrategy.new(resolve(path.to_s), RpgLib::RollSet.new(*args)).value
    end

    def roll_on_and_ignore_duplicates(path, times)
      RollAndIgnoreDuplicatesStrategy.new(resolve(path.to_s), times).value
    end

    private

    def resolve(path)
      namespace = @namespace
      until namespace.nil?
        return namespace.resolve(path) if namespace.resolve?(path)
        namespace = namespace.parent
      end
      raise Exception, "No such table #{path}"
    end
  end
end
