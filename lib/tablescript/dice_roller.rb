module TableScript
  
  class DiceRoller
  
    def roll_dice( count, die )
      total = 0
      1.upto count do
        total += rand( 1..die )
      end
      total
    end
  
    def roll( dice )
      while m = dice.downcase.match( /\d*d\d+/ ) do
        count, die = decode_dice( m[ 0 ] )
        rolled_value = roll_dice( count, die )
        dice[ m.begin( 0 )...m.end( 0 ) ] = rolled_value.to_s
      end
      eval( dice )
    end
  
    def roll_and_ignore( dice, args )
      puts "ignoring #{args}"
      count, die = decode_dice( dice )
      ignored_values = collect_ignored_values( args )
      rolled_value = nil
      while rolled_value.nil? do
        rolled_value = roll_dice( count, die )
        if ignored_values.include? rolled_value
          rolled_value = nil
        end
      end
      rolled_value
    end
  
    private
  
      def decode_dice( dice )
        dice.downcase.split( 'd' ).map { |n| n.empty? ? 1 : n.to_i }
      end
    
      def collect_ignored_values( args )
        ignored_values = []
        until args.empty? do
          value = args.shift
          if value.class == Fixnum
            ignored_values << value
          elsif value.class == Range
            value.each do |i|
              ignored_values << i
            end
          end
        end
        ignored_values
      end
  
  end

end
