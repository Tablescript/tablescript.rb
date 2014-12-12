module TableScript
  
  class TableEntryEnvironment
  
    def initialize( roller )
      @roller = roller
      @entries = []
    end
  
    def f( *args, &blk )
      if args.empty?
        @entries << TableEntry.new( blk )
      else
        roll = args.shift
        if roll.class == Fixnum
          @entries[ roll - 1 ] = TableEntry.new( blk )
        elsif roll.class == Range
          entry = TableEntry.new( blk )
          roll.each do |i|
            @entries[ i - 1 ] = entry
          end
        end
        raise "Too many parameters for f" unless args.empty?
      end
    end
  
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
      raise "Undefined method #{method_id}"
    end
  
    private
    
      def entries_from_ignored_values( args )
        entries = []
        args.each do |arg|
          if arg.class == Fixnum
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
