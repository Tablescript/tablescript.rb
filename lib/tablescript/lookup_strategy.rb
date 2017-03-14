module Tablescript
  ##
  # LookupStrategy
  #
  class LookupStrategy
    def initialize(table, roll)
      @table = table
      @roll = roll
      @value = nil
    end

    def value
      evaluate
      @value
    end

    private

    def evaluate
      return unless @value.nil?
      @table.lookup(@roll).evaluate(@roll, @table)
    end
  end
end
