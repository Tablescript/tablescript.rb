require 'spec_helper'

module Tablescript
  describe Library do
    it 'is a singleton' do
      expect { Library.instance }.not_to raise_error
    end

    describe 'add' do
      let(:table) { double('table', name: :table) }
      let(:library) { Library.instance }

      before(:each) do
        Library.instance = Library.new
      end

      it 'knows it has added table' do
        library.add(table)
        expect(library.table?(:table)).to be true
      end

      it 'retrieves the table' do
        library.add(table)
        expect(library.table(:table)).to eq(table)
      end

      describe 'duplicates' do
        it 'throws when trying to add a duplicate' do
          library.add(table)
          expect { library.add(table) }.to raise_error(Exception)
        end
      end
    end
  end
end
