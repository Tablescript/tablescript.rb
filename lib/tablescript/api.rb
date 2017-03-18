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
  # Api
  #
  module Api
    def table(name, &blk)
      generator = TableGenerator.new
      generator.instance_eval(&blk)
      Library.instance.add(Table.new(name, generator.entries))
    end

    def roll_on(name)
      ensure_table_exists(name)
      RollStrategy.new(Library.instance.table(name)).value
    end

    def roll_on_and_ignore(name, *args)
      ensure_table_exists(name)
      RollAndIgnoreStrategy.new(Library.instance.table(name), RpgLib::RollSet.new(*args)).value
    end

    def roll_on_and_ignore_duplicates(name, times)
      ensure_table_exists(name)
      RollAndIgnoreDuplicatesStrategy.new(Library.instance.table(name), times).values
    end

    def lookup(name, roll)
      ensure_table_exists(name)
      LookupStrategy.new(Library.instance.table(name), roll).value
    end

    def ensure_table_exists(name)
      raise "No table named '#{name}'" unless Library.instance.table?(name)
    end
  end
end
