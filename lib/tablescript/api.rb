# Copyright 2015 Jamie Hale
#
# This file is part of the Tablescript gem.
#
# Tablescript.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Tablescript.rb is distributed in the hope that it will be useful,
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
  class Api
    def self.table(name, &blk)
      begin
        new_table = Table.new(name, DiceRoller.new)
        new_table.build(&blk)
        Library.instance.add(new_table)
      rescue StandardError => e
        puts e
        exit
      end
    end

    def self.roll_on(name)
      ensure_table_exists(name)
      Library.instance.table(name).roll
    end

    def self.roll_on_and_ignore_duplicates(name, times, *args)
      ensure_table_exists(name)
      Library.instance.table(name).roll_and_ignore_duplicates(times, args)
    end

    def self.lookup(name, roll)
      ensure_table_exists(name)
      Library.instance.table(name).lookup(roll)
    end

    def self.roll_dice(dice)
      Tablescript::DiceRoller.new.roll(dice.dup)
    end

    def self.choose(options)
      options[DiceRoller.new.random_value_in_range(1..options.size) - 1]
    end

    private

    def self.ensure_table_exists(name)
      raise "No table named '#{name}'" unless Library.instance.table?(name)
    end
  end
end

def table(name, &blk)
  Tablescript::Api.table(name, &blk)
end

def roll_on(name)
  Tablescript::Api.roll_on(name)
end

def roll_on_and_ignore_duplicates(name, times, *args)
  Tablescript::Api.roll_on_and_ignore_duplicates(name, times, *args)
end

def lookup(name, roll)
  Tablescript::Api.lookup(name, roll)
end

def roll_dice(dice)
  Tablescript::Api.roll_dice(dice)
end

def choose(options)
  Tablescript::Api.choose(options)
end
