module Tablescript
  ##
  # RollAndIgnoreStrategy
  #
  class RollAndIgnoreStategy
    def initialize(table, rollset)
      @table = table
      @rollset = rollset
      @roll = nil
      @value = nil
    end

    def roll
      evaluate
      @roll
    end

    def value
      evaluate
      @value
    end

    private

    def evaluate
      return unless @roll.nil?
      @roll = DiceRoller.instance.roll_and_ignore(@table.dice_to_roll, @rollset)
      @value = @table.lookup(@roll).evaluate(@roll, @table)
    end
  end
end
