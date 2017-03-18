module Tablescript
  ##
  # TableEntries
  #
  class TableEntries
    def initialize
      @entries = []
      @next_id = 0
    end

    def size
      @entries.size
    end

    def entry(index)
      @entries[index]
    end

    def lookup(roll)
      entry(roll - 1)
    end

    def add_fixed(roll, &blk)
      if roll.nil?
        add_entry(blk)
      elsif roll.is_a?(Integer)
        set_entry(roll, blk)
      elsif roll.is_a?(Range)
        set_range(roll, blk)
      else
        raise Exception, "Unrecognized parameter type (#{roll.class}) for fixed roll definition"
      end
    end

    def add_dynamic(count, &blk)
      range = next_single_roll..(next_single_roll + count - 1)
      entry = TableEntry.new(next_id, range, blk)
      count.times { @entries << entry }
    end

    private

    def next_id
      id = @next_id
      @next_id += 1
      id
    end

    def next_single_roll
      @entries.size + 1
    end

    def add_entry(blk)
      @entries << TableEntry.new(next_id, next_single_roll, blk)
    end

    def set_entry(roll, blk)
      @entries[roll - 1] = TableEntry.new(next_id, roll, blk)
    end

    def set_range(range, blk)
      entry = TableEntry.new(next_id, range, blk)
      range.each { |r| @entries[r - 1] = entry }
    end
  end
end
