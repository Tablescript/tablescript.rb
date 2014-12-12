module TableScript
  
  class DiceRoller
  
    @@DICE_REGEXP = /(\d*)d(\d+)((dl)(\d*)|(dh)(\d*))?/
    
    def roll_dice( roll_descriptor )
      rolled_values = []
      1.upto roll_descriptor.count do
        rolled_values << rand( 1..roll_descriptor.die )
      end
      rolled_values.sort!
      rolled_values.slice!( 0, roll_descriptor.drop_lowest )
      rolled_values.slice!( rolled_values.size - roll_descriptor.drop_highest, roll_descriptor.drop_highest )
      rolled_values.inject( 0 ) { |total,rolled_value| total + rolled_value }
    end
  
    def roll( dice )
      while m = dice.downcase.match( @@DICE_REGEXP ) do
        rolled_value = roll_dice( RollDescriptor.new( m ) )
        dice[ m.begin( 0 )...m.end( 0 ) ] = rolled_value.to_s
      end
      eval( dice )
    end
  
    def roll_and_ignore( dice, args )
      ignored_values = collect_ignored_values( args )
      rolled_value = nil
      while rolled_value.nil? do
        rolled_value = roll( dice )
        if ignored_values.include? rolled_value
          rolled_value = nil
        end
      end
      rolled_value
    end
  
    private
  
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
        ignored_values.uniq
      end
  
  end

end
