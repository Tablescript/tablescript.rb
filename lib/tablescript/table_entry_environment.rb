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
          roll.each do |i|
            @entries[ i - 1 ] = TableEntry.new( blk )
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
      @entries[ index - 1 ]
    end
  
    def reroll
      rolled_value = @roller.roll( dice_to_roll )
      lookup( rolled_value ).evaluate( rolled_value )
    end
  
    def reroll_and_ignore( *args )
      validate_ignored_values( args )
      rolled_value = @roller.roll_and_ignore( dice_to_roll, args )
      lookup( rolled_value ).evaluate( rolled_value )
    end
  
    def method_missing( method_id, *args )
      raise "Valid table rows are s and m"
    end
  
    private
  
      def validate_ignored_values( args )
        raise "No ignored values specified" if args.empty?
      end
  
  end

end
