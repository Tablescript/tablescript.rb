require 'spec_helper'

module Tablescript
  describe RollStrategy do
    it 'can be created' do
      expect { RollStrategy.new(:table) }.not_to raise_error
    end

    describe 'evaluate' do
      let(:dice) { 'd20' }
      let(:table) { double('table', dice_to_roll: dice) }
      let(:roll) { 6 }
      let(:value) { 'Vorpal sword' }
      let(:roller) { DiceRoller.clone.instance }
      let(:strategy) { RollStrategy.new(table, roller) }

      before(:each) do
        allow(roller).to receive(:roll) { roll }
        allow(table).to receive(:evaluate) { value }
        @value = strategy.value
      end

      it 'defers to the roller' do
        expect(roller).to have_received(:roll).with(dice)
      end

      it 'defers to the table' do
        expect(table).to have_received(:evaluate).with(roll)
      end

      describe 'value' do
        it 'provides the tables result' do
          expect(@value).to eq(value)
        end

        it 'only evaluates once' do
          strategy.value
          strategy.value
          expect(table).to have_received(:evaluate).once
        end
      end

      describe 'roll' do
        it 'knows its roll' do
          expect(strategy.roll).to eq(roll)
        end

        it 'only evaluates once' do
          strategy.roll
          strategy.roll
          expect(table).to have_received(:evaluate).once
        end
      end
    end
  end
end
