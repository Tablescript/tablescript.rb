module TableScript
  
  class Table
  
    attr_reader :entries
  
    def initialize( name, roller )
      @name = name
      @roller = roller
      @entries = nil
    end
  
    def build( &blk )
      @entries = TableEntryEnvironment.new( @roller )
      @entries.instance_eval( &blk )
    end
  
    def random_entry
      @roller.rollD( @entries.die_to_roll )
    end
  
    def lookup( index )
      @entries.lookup_and_evaluate( index )
    end
  
    def roll
      @entries.reroll
    end
    
    def roll_and_ignore_duplicates( times, args )
      @entries.reroll_and_ignore_duplicates( times, args )
    end
  
  end

end
