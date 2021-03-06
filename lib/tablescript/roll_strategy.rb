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
  # RollStrategy
  #
  class RollStrategy
    def initialize(table, roller = nil)
      @table = table
      @roller = roller || RpgLib::DiceRoller.instance
      @roll = nil
      @value = nil
    end

    def roll
      evaluate
      @roll
    end

    def value
      evaluate
      @value
    end

    private

    def evaluate
      return unless @roll.nil?
      @roll = @roller.roll_die(@table.entries.size)
      @value = @table.lookup(@roll)
    end
  end
end
