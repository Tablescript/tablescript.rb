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
    def namespace(name, &blk)
      generator = NamespaceGenerator.new(Path.join('/', name.to_s))
      generator.instance_eval(&blk)
    end

    def table(name, &blk)
      generator = TableGenerator.new
      generator.instance_eval(&blk)
      Library.instance.add(Table.new(Path.join('/', name.to_s), generator.entries))
    end

    def roll_on(name)
      table = Library.instance.table(name.to_s)
      table = Library.instance.table(Path.join('/', name.to_s)) if table.nil?
      raise "No table named '#{name}'" if table.nil?
      RollStrategy.new(table).value
    end

    def roll_on_and_ignore(name, *args)
      table = Library.instance.table(name.to_s)
      table = Library.instance.table(Path.join('/', name.to_s)) if table.nil?
      raise "No table named '#{name}'" if table.nil?
      RollAndIgnoreStrategy.new(table, RpgLib::RollSet.new(*args)).value
    end

    def roll_on_and_ignore_duplicates(name, times)
      table = Library.instance.table(name.to_s)
      table = Library.instance.table(Path.join('/', name.to_s)) if table.nil?
      raise "No table named '#{name}'" if table.nil?
      RollAndIgnoreDuplicatesStrategy.new(table, times).values
    end

    def lookup(name, roll)
      table = Library.instance.table(name.to_s)
      table = Library.instance.table(Path.join('/', name.to_s)) if table.nil?
      raise "No table named '#{name}'" if table.nil?
      LookupStrategy.new(table, roll).value
    end

    def ensure_table_exists(name)
      raise "No table named '#{name}'" unless Library.instance.table?(name)
    end
  end
end
