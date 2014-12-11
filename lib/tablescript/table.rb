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
      @entries.lookup( index )
    end
  
    def roll
      @entries.reroll
    end
  
  end

end
