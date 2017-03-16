require 'spec_helper'

module Tablescript
  describe RollAndIgnoreStrategy do
    it 'can be created' do
      expect { RollAndIgnoreStrategy.new(:table, :rollset) }.not_to raise_error
    end

    describe 'evaluate' do
      let(:dice) { 'd20' }
      let(:table) { double('table', dice_to_roll: dice) }
      let(:rollset) { double('rollset') }
      let(:roll) { 6 }
      let(:value) { 'Vorpal sword' }
      let(:roller) { RpgLib::DiceRoller.clone.instance }
      let(:strategy) { RollAndIgnoreStrategy.new(table, rollset, roller) }

      before(:each) do
        allow(roller).to receive(:roll_and_ignore) { roll }
        allow(table).to receive(:evaluate) { value }
        @value = strategy.value
      end

      it 'defers to the roller' do
        expect(roller).to have_received(:roll_and_ignore).with(dice, rollset)
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
