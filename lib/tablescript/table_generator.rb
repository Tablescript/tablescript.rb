module Tablescript
  ##
  # TableGenerator
  #
  class TableGenerator
    def initialize(name)
      @name = name
      @entries = []
      @next_id = 0
    end

    def generate(&blk)
      instance_eval(&blk)
      Table.new(@name, @entries)
    end

    def fixed(*args, &blk)
      if args.empty?
        add_entry(blk)
      else
        roll = args.shift
        if roll.is_a?(Integer)
          set_entry(roll, blk)
        elsif roll.is_a?(Range)
          set_range(roll, blk)
        else
          raise Exception, "Unrecognized parameter type (#{roll.class}) for fixed roll definition in #{@name}"
        end
        raise Exception, "Extra parameters (#{args.join(',')}) for f in table #{@name}" unless args.empty?
      end
    end

    alias f fixed

    def dynamic(*args, &blk)
      if args.empty?
        add_entry(blk)
      else
        count = args.shift
        raise Exception, "Unrecognized parameter type (#{count}) for dynamic roll definition in #{@name}" unless count.is_a?(Integer)
        add_count(count, blk)
        raise Exception, "Extra parameters (#{args.join(',')}) for d in table #{@name}" unless args.empty?
      end
    end

    alias d dynamic

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

    def add_cont(count, blk)
      entry = TableEntry.new(next_id, range, blk)
      count.times { @entries << entry }
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
