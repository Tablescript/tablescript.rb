module Tablescript
  ##
  # NamespaceGenerator
  #
  class NamespaceGenerator
    def initialize(scope)
      @scope = scope
    end

    def namespace(name, &blk)
      generator = NamespaceGenerator.new(@scope.namespace(name.to_s))
      generator.instance_eval(&blk)
    end

    def table(name, &blk)
      table = Table.new(name.to_s, @scope, &blk)
      @scope.add(table)
    end
  end
end
