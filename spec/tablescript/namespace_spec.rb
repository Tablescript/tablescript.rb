module Tablescript
  describe Namespace do
    describe 'add' do
      let(:table) { double('table', name: :table) }
      let(:namespace) { Namespace.new }

      it 'knows it has added table' do
        namespace.add(table)
        expect(namespace.table?(:table)).to be true
      end

      it 'retrieves the table' do
        namespace.add(table)
        expect(namespace.table(:table)).to eq(table)
      end

      describe 'duplicates' do
        it 'throws when trying to add a duplicate' do
          namespace.add(table)
          expect { namespace.add(table) }.to raise_error(Exception)
        end
      end
    end
  end
end
