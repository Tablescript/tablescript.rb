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
    
module TableScript
  
  class TableEntryEnvironment
  
    def initialize( table_name, roller )
      @table_name = table_name
      @roller = roller
      @entries = []
    end
  
    def fixed( *args, &blk )
      if args.empty?
        @entries << TableEntry.new( blk )
      else
        roll = args.shift
        if roll.is_a?(Integer)
          @entries[ roll - 1 ] = TableEntry.new( blk )
        elsif roll.class == Range
          entry = TableEntry.new( blk )
          roll.each do |i|
            @entries[ i - 1 ] = entry
          end
        end
        raise "Too many parameters for f in table #{@table_name}" unless args.empty?
      end
    end
    
    alias :f :fixed
    
    def dynamic( *args, &blk )
      if args.empty?
        @entries << TableEntry.new( blk )
      else
        count = args.shift
        if count.is_a?(Integer)
          entry = TableEntry.new( blk )
          1.upto count do
            @entries << entry
          end
        end
        raise "Too many parameters for d in table #{@table_name}" unless args.empty?
      end
    end
    
    alias :d :dynamic
  
    def dice_to_roll
      "d#{@entries.size}"
    end
  
    def lookup( index )
      raise "No table entry for a roll of #{index}." if ( index <= 0 or index > @entries.size )
      @entries[ index - 1 ].evaluate( index )
    end
    
    def reroll
      rolled_value = @roller.roll( dice_to_roll )
      lookup( rolled_value )
    end
  
    def reroll_and_ignore( *args )
      validate_ignored_values( args )
      rolled_value = @roller.roll_and_ignore( dice_to_roll, args )
      lookup( rolled_value )
    end
    
    def reroll_and_ignore_duplicates( times, *args )
      ignored_entries = entries_from_ignored_values( args )
      evaluated_rolled_entries = []
      until evaluated_rolled_entries.size == times do
        rolled_value = @roller.roll( dice_to_roll )
        rolled_entry = @entries[ rolled_value - 1 ]
        unless ignored_entries.include? rolled_entry
          ignored_entries << rolled_entry
          evaluated_rolled_entries << rolled_entry.evaluate( rolled_value )
        end
      end
      evaluated_rolled_entries
    end
    
    def method_missing( method_id, *args )
      raise "Undefined command '#{method_id}' in table #{@table_name}"
    end
  
    private
    
      def entries_from_ignored_values( args )
        entries = []
        args.each do |arg|
          if arg.is_a?(Integer)
            entries << lookup( arg )
          elsif arg.class == Range
            arg.each do |i|
              entries << lookup( arg )
            end
          end
        end
        entries.uniq
      end
  
      def validate_ignored_values( args )
        raise "No ignored values specified" if args.empty?
      end
  
  end

end
