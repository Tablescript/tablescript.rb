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
      generator = NamespaceGenerator.new(Library.instance.root.namespace(name.to_s))
      generator.instance_eval(&blk)
    end

    def table(name, &blk)
      root_namespace = Library.instance.root
      table = Table.new(name.to_s, root_namespace, &blk)
      root_namespace.add(table)
    end

    def roll_on(path)
      RollStrategy.new(Library.instance.table(path.to_s)).value
    end

    def roll_on_and_ignore(path, *args)
      RollAndIgnoreStrategy.new(Library.instance.table(path.to_s), RpgLib::RollSet.new(*args)).value
    end

    def roll_on_and_ignore_duplicates(path, times)
      RollAndIgnoreDuplicatesStrategy.new(Library.instance.table(path.to_s), times).values
    end

    def lookup(path, roll)
      LookupStrategy.new(Library.instance.table(path.to_s), roll).value
    end
  end
end
