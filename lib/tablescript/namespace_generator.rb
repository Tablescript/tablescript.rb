module Tablescript
  ##
  # NamespaceGenerator
  #
  class NamespaceGenerator
    def initialize(scope)
      @scope = scope
    end

    def namespace(name, &blk)
      generator = NamespaceGenerator(@scope + '/' + name)
      generator.instance_eval(&blk)
    end

    def table(name, description, &blk)
      generator = TableGenerator.new(name, description)
      generator.instance_eval(&blk)
      Library.instance.add(Table.new(@scope + '/' + name, description))
    end
  end
end
