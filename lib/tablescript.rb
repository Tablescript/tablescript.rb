# Copyright 2015 Jamie Hale
#
# This file is part of the Tablescript.rb gem.
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
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
    
require 'tablescript/dice_roller'
require 'tablescript/roll_descriptor'
require 'tablescript/table'
require 'tablescript/table_entry'
require 'tablescript/table_entry_environment'

$LOAD_PATH.push File.expand_path( ENV[ "TS_PATH" ] ) unless ENV[ "TS_PATH" ].nil?

$all_tables = {}

def table( name, &blk )
  begin
    new_table = TableScript::Table.new( name, TableScript::DiceRoller.new )
    new_table.build( &blk )
    $all_tables[ name ] = new_table
  rescue Exception => e
    puts e
    exit
  end
end

def roll_on( name )
  raise "No table named '#{name}'" if $all_tables[ name ].nil?
  $all_tables[ name ].roll
end

def roll_on_and_ignore_duplicates( name, times, *args )
  begin
    raise "No table named '#{name}'" if $all_tables[ name ].nil?
    $all_tables[ name ].roll_and_ignore_duplicates( times, args )
  rescue Exception => e
    puts e
    exit
  end
end

def lookup( name, roll )
  begin
    raise "No table named '#{name}'" if $all_tables[ name ].nil?
    $all_tables[ name ].lookup( roll )
  rescue Exception => e
    puts e
    exit
  end
end

def roll_dice( dice )
  begin
    TableScript::DiceRoller.new.roll( dice.dup )
  rescue Exception => e
    puts e
    exit
  end
end

def choose( options )
  options[ TableScript::DiceRoller.new.random_value_in_range( 1..options.size ) - 1 ]
end

class String
  def roll
    roll_dice(self)
  end
end
