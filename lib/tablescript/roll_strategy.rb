module Tablescript
  ##
  # RollStrategy
  #
  class RollStrategy
    def initialize(table)
      @table = table
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
      @roll = DiceRoller.instance.roll(@table.dice_to_roll)
      @value = @table.evaluate(@roll)
    end
  end
end
