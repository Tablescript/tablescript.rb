module Tablescript
  ##
  # RollAndIgnoreDuplicatesStrategy
  #
  class RollAndIgnoreDuplicatesStrategy
    def initialize(table, roll_count, ignore = nil)
      @table = table
      @roll_count = roll_count
      @roll_history = ignore || RollSet.new
      @entry_ids = Set.new
      @rolls = []
      @values = []
    end

    def rolls
      evaluate
      @rolls
    end

    def values
      evaluate
      @values
    end

    private

    def evaluate
      loop do
        roll_next_value
        break if @values.size == @roll_count
      end
    end

    def roll_next_value
      roll = next_roll(@table.dice_to_roll)
      entry = @table.lookup(roll)
      return if @entry_ids.include?(entry.id)
      record(roll, entry)
    end

    def record(roll, entry)
      @entry_ids.add(entry.id)
      @roll_history.add(entry.roll)
      @rolls << roll
      @values << entry.evaluate(roll, @table)
    end

    def next_roll(dice)
      DiceRoller.instance.roll_and_ignore(dice, @roll_history)
    end
  end
end
