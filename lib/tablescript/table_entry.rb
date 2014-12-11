module TableScript
  
  class TableEntry
    
    def initialize( blk )
      @blk = blk
    end
    
    def evaluate( roll )
      @blk.call( roll )
    end
  end

end
