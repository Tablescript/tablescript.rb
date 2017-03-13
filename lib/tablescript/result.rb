module Tablescript
  ##
  # Result
  #
  class Result
    attr_reader :roll, :value

    def initialize(roll, value)
      @roll = roll
      @value = value
    end
  end
end
