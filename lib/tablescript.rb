require 'tablescript/dice_roller'
require 'tablescript/table'
require 'tablescript/table_entry'
require 'tablescript/table_entry_environment'

$all_tables = {}

def table( name, &blk )
  new_table = TableScript::Table.new( name, TableScript::DiceRoller.new )
  new_table.build( &blk )
  $all_tables[ name ] = new_table
end

def roll_on( name )
  raise "No table named '#{name}'" if $all_tables[ name ].nil?
  $all_tables[ name ].roll
end

def roll_on_and_ignore_duplicates( name, times, *args )
  raise "No table named '#{name}'" if $all_tables[ name ].nil?
  $all_tables[ name ].roll_and_ignore_duplicates( times, args )
end

def lookup( name, roll )
  raise "No table named '#{name}'" if $all_tables[ name ].nil?
  $all_tables[ name ].lookup( roll )
end
