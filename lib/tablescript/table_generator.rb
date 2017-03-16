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
  # TableGenerator
  #
  class TableGenerator
    attr_reader :entries

    def initialize
      @entries = []
      @next_id = 0
    end

    def fixed(roll = nil, &blk)
      if roll.nil?
        add_entry(blk)
      elsif roll.is_a?(Integer)
        set_entry(roll, blk)
      elsif roll.is_a?(Range)
        set_range(roll, blk)
      else
        raise Exception, "Unrecognized parameter type (#{roll.class}) for fixed roll definition"
      end
    end

    alias f fixed

    def dynamic(count = 1, &blk)
      range = next_single_roll..(next_single_roll + count - 1)
      entry = TableEntry.new(next_id, range, blk)
      count.times { @entries << entry }
    end

    alias d dynamic

    private

    def next_id
      id = @next_id
      @next_id += 1
      id
    end

    def next_single_roll
      @entries.size + 1
    end

    def add_entry(blk)
      @entries << TableEntry.new(next_id, next_single_roll, blk)
    end

    def set_entry(roll, blk)
      @entries[roll - 1] = TableEntry.new(next_id, roll, blk)
    end

    def set_range(range, blk)
      entry = TableEntry.new(next_id, range, blk)
      range.each { |r| @entries[r - 1] = entry }
    end
  end
end
