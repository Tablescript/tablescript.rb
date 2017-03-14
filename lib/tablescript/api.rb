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
      generator = TableGenerator.new(name)
      Library.instance.add(generator.generate(&blk))
    end

    def self.roll_on(name)
      ensure_table_exists(name)
      RollStrategy.new(Library.instance.table(name)).value
    end

    def self.roll_on_and_ignore(name, *args)
      ensure_table_exists(name)
      RollAndIgnoreStrategy.new(Library.instance.table(name), RollSet.new(*args)).value
    end

    def self.roll_on_and_ignore_duplicates(name, times)
      ensure_table_exists(name)
      RollAndIgnoreDuplicatesStrategy.new(Library.instance.table(name), times).values
    end

    def self.lookup(name, roll)
      ensure_table_exists(name)
      LookupStrategy.new(Library.instance.table(name), roll).value
    end

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

def roll_on_and_ignore(name, *args)
  Tablescript::Api.roll_on_and_ignore(name, *args)
end

def roll_on_and_ignore_duplicates(name, times)
  Tablescript::Api.roll_on_and_ignore_duplicates(name, times)
end

def lookup(name, roll)
  Tablescript::Api.lookup(name, roll)
end

def roll_dice(dice)
  Tablescript::DiceRoller.instance.roll(dice.dup)
end

def roll_dice_and_ignore(dice, *args)
  Tablescript::DiceRoller.instance.roll_and_ignore(dice.dup, Tablescript::RollSet.new(*args))
end

def choose(options)
  options[Tablescript::DiceRoller.instance.random_value_in_range(1..options.size) - 1]
end

def roll_set(*args)
  Tablescript::RollSet.new(*args)
end
