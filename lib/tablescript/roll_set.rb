require 'set'

module Tablescript
  ##
  # RollSet
  #
  class RollSet
    attr_reader :rolls

    def initialize(*args)
      @rolls = Set.new
      args.each { |a| add(a) }
    end

    def include?(roll)
      @rolls.include?(roll)
    end

    def add(r)
      if r.is_a?(Integer)
        @rolls.add(r)
      elsif r.is_a?(Range)
        r.to_a.map { |e| @rolls.add(e) }
      elsif roll.is_a?(RollSet)
        @rolls.merge(r.rolls)
      end
    end
  end
end
