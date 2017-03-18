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
  #
  #
  class RollContext
    attr_reader :roll

    def initialize(roll, table, entry)
      @roll = roll
      @table = table
      @entry = entry
    end

    def table_name
      @table.name
    end

    def dice_rolled
      @table.dice_to_roll
    end
  end
end
