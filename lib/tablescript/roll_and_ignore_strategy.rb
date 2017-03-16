module Tablescript
  ##
  # RollAndIgnoreStrategy
  #
  class RollAndIgnoreStrategy
    def initialize(table, rollset, roller = nil)
      @table = table
      @rollset = rollset
      @roller = roller || RpgLib::DiceRoller.instance
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
      @roll = @roller.roll_and_ignore(@table.dice_to_roll, @rollset)
      @value = @table.evaluate(@roll)
    end
  end
end
