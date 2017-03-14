require 'spec_helper'

module Tablescript
  describe LookupStrategy do
    it 'can be created' do
      expect { LookupStrategy.new(:table, :roll) }.not_to raise_error
    end

    describe 'value' do
      let(:table) { double('table') }
      let(:roll) { 6 }
      let(:value) { 'Vorpal sword' }
      let(:strategy) { LookupStrategy.new(table, roll) }

      before(:each) do
        allow(table).to receive(:evaluate) { value }
        @value = strategy.value
      end

      it 'defers to the table' do
        expect(table).to have_received(:evaluate).with(roll)
      end

      it 'provides the tables result' do
        expect(@value).to eq(value)
      end

      it 'does not evaluate twice' do
        strategy.value
        strategy.value
        expect(table).to have_received(:evaluate).once
      end
    end
  end
end
