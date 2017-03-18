module Tablescript
  ##
  # NamespaceGenerator
  #
  class NamespaceGenerator
    def initialize(scope)
      @scope = scope
    end

    def namespace(name, &blk)
      generator = NamespaceGenerator(@scope.namespace(name))
      generator.instance_eval(&blk)
    end

    def table(name, &blk)
      generator = TableGenerator.new
      generator.instance_eval(&blk)
      @scope.add(Table.new(name.to_s, @scope, generator.entries))
    end
  end
end
