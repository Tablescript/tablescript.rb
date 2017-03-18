require 'spec_helper'

module Tablescript
  describe Library do
    it 'is a singleton' do
      expect { Library.instance }.not_to raise_error
    end

    it 'knows its root namespace' do
      expect(Library.instance.root).to be_a(Namespace)
    end
  end
end
