require 'tablescript/dice_roller'
require 'tablescript/roll_descriptor'
require 'tablescript/table'
require 'tablescript/table_entry'
require 'tablescript/table_entry_environment'

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
    TableScript::DiceRoller.new.roll( dice )
  rescue Exception => e
    puts e
    exit
  end
end

def choose( options )
  options[ TableScript::DiceRoller.new.random_value_in_range( 1..options.size ) - 1 ]
end
