module Tablescript
  ##
  # Path
  #
  class Path
    def self.split(path)
      path.split('/')
    end

    def self.join(part, *args)
      results = split(part)
      args.each do |part|
        tokens = split(part)
        tokens.each do |token|
          if token == '..'
            results.pop
          else
            results << token
          end
        end
      end
      results.join('/')
    end

    def self.resolve(path)
      results = []
      split(path).each do |part|
        if part == '..'
          results.pop
        else
          results << part
        end
      end
      results.join('/')
    end

    private

    def initialize
    end
  end
end
