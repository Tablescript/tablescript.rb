require 'spec_helper'

module Tablescript
  describe Table do
    it 'can be created' do
      expect { Table.new(:name, :namespace, :entries) }.not_to raise_error
    end

    describe 'dice_to_roll' do
      describe 'small table' do
        let(:table) { Table.new(:name, :namespace, [:entry] * 5) }

        it 'knows its size' do
          expect(table.size).to be 5
        end

        it 'knows what to roll' do
          expect(table.dice_to_roll).to eq('d5')
        end
      end

      describe 'large table' do
        let(:table) { Table.new(:name, :namespace, [:entry] * 100) }

        it 'knows its size' do
          expect(table.size).to be 100
        end

        it 'knows what to roll' do
          expect(table.dice_to_roll).to eq('d100')
        end
      end
    end

    describe 'entries' do
      let(:entry1) { double('entry1') }
      let(:entry2) { double('entry2') }
      let(:entry3) { double('entry3') }
      let(:entry4) { double('entry4') }
      let(:entries) { [entry1, entry2, entry3, entry4] }
      let(:table) { Table.new(:name, :namespace, entries) }

      describe 'lookup' do
        it 'knows its entries by roll' do
          1.upto(4) do |i|
            expect(table.lookup(i)).to eq entries[i - 1]
          end
        end

        it 'throws for an unset roll' do
          expect { table.lookup(100) }.to raise_error Exception
        end
      end

      describe 'entry' do
        it 'knows its entries by index' do
          0.upto(3) do |i|
            expect(table.entry(i)).to eq entries[i]
          end
        end

        it 'returns nil for an unset index' do
          expect(table.entry(100)).to be_nil
        end
      end
    end

    describe 'evaluate' do
      let(:entry) { double('entry') }
      let(:entries) { [entry] }
      let(:value) { 9 }
      let(:table) { Table.new(:name, :namespace, entries) }

      before(:each) do
        allow(entry).to receive(:evaluate) { value }
        @value = table.evaluate(1)
      end

      it 'defers to the entry' do
        expect(entry).to have_received(:evaluate).with(1, table)
      end

      it 'returns the value returned by the entry' do
        expect(@value).to eq(value)
      end
    end
  end
end
