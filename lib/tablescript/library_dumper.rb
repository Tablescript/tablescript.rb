module Tablescript
  ##
  # LibraryDumper
  #
  class LibraryDumper
    def initialize(stream = STDOUT)
      @stream = stream
    end

    def dump(library = nil)
      dump_namespace(library.nil? ? Library.instance.root : library)
    end

    private

    def dump_namespace(namespace, level = 0)
      @stream.puts indent(level) + "Namespace #{namespace.name}"
      dump_tables(namespace.tables, level + 1)
      dump_namespaces(namespace.namespaces, level + 1)
    end

    def dump_tables(tables, level)
      return if tables.empty?
      @stream.puts indent(level) + 'Tables:'
      tables.each_value do |table|
        @stream.puts indent(level + 1) + table.name
      end
    end

    def dump_namespaces(namespaces, level)
      return if namespaces.empty?
      @stream.puts indent(level) + 'Namespaces:'
      namespaces.each_value do |namespace|
        dump_namespace(namespace, level + 1)
      end
    end

    def indent(level)
      "  " * level
    end
  end
end
