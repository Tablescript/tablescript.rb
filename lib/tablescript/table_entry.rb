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
  # TableEntry
  #
  class TableEntry
    attr_reader :id, :roll, :blk

    def initialize(id, roll, blk)
      @id = id
      @roll = roll
      @blk = blk
    end

    def evaluate(roll, table, entry_environment = nil)
      environment = entry_environment || TableEntryEnvironment.new(roll, table, self)
      environment.instance_eval(&@blk)
    end
  end
end
