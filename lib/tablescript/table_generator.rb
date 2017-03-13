module Tablescript
  ##
  # TableGenerator
  #
  class TableGenerator
    def initialize(name)
      @table = Table.new(name, DiceRoller.new)
    end

    def generate(&blk)
      instance_eval(&blk)
      @table
    end

    def fixed(*args, &blk)
      if args.empty?
        @table.add_entry(TableEntry.new(blk, @table))
      else
        roll = args.shift
        if roll.is_a?(Integer)
          @table.set_entry(roll, TableEntry.new(blk, @table))
        elsif roll.is_a?(Range)
          entry = TableEntry.new(blk, @table)
          roll.each do |i|
            @table.set_entry(i, entry)
          end
        end
        raise "Too many parameters for f in table #{@table.name}" unless args.empty?
      end
    end

    alias f fixed

    def dynamic(*args, &blk)
      if args.empty?
        @table.add_entry(TableEntry.new(blk, @table))
      else
        count = args.shift
        if count.is_a?(Integer)
          entry = TableEntry.new(blk, @table)
          1.upto count do
            @table.add_entry(entry)
          end
        end
        raise "Too many parameters for d in table #{@table.name}" unless args.empty?
      end
    end

    alias d dynamic
  end
end
