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
  # Namespace
  #
  class Namespace
    attr_reader :parent

    def initialize(name = '', parent = nil)
      @name = name
      @parent = parent
      @namespaces = {}
      @tables = {}
    end

    def add(table)
      raise Exception, "Table #{table.name} already defined" if @tables.key?(table.name)
      @tables[table.name] = table
    end

    def resolve?(path)
      begin
        resolve(path)
      rescue Tablescript::Exception
        return false
      end
      true
    end

    def resolve(path)
      parts = path.split('/')
      return table(path) if parts.size == 1
      if parts[0] == @name
        return table(parts[1]) if parts.size == 2
        raise Exception, "Namespace #{parts[1]} not found in #{name} namespace (#{path})" unless @namespaces.key?(parts[1])
        return @namespaces[parts[1]].resolve(parts[1..-1].join('/'))
      else
        raise Exception, "Namespace #{parts[0]} not found in #{name} namespace (#{path})" unless @namespaces.key?(parts[0])
        return @namespaces[parts[0]].resolve(parts[1..-1].join('/'))
      end
    end

    def table(table_name)
      raise Exception, "No such table #{table_name} in #{name}" unless @tables.key?(table_name)
      @tables[table_name]
    end

    def table?(table_name)
      @tables.key?(table_name)
    end

    def namespace(name)
      @namespaces[name] ||= Namespace.new(name, self)
    end

    def name
      return 'global' if @parent.nil?
      @name
    end

  end
end
