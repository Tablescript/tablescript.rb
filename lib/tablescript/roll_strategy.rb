module Tablescript
  ##
  # RollStrategy
  #
  class RollStrategy
    def initialize(table, roller = nil)
      @table = table
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
      @roll = @roller.roll(@table.dice_to_roll)
      @value = @table.evaluate(@roll)
    end
  end
end
