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
      count, die = decode_dice( dice )
      roll_dice( count, die )
    end
  
    def roll_and_ignore( dice, args )
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
        count, die = dice.downcase.split( 'd' ).map { |n| n.empty? ? 1 : n.to_i }
        return count, die
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
