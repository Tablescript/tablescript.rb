require 'spec_helper'

module Tablescript
  describe TableEntryEnvironment do
    it 'can be created' do
      expect { TableEntryEnvironment.new(:roll, :table, :entry) }.not_to raise_error
    end

    describe 'once created' do
      let(:roll) { double('roll') }
      let(:table_name) { 'table1' }
      let(:dice) { 'd20' }
      let(:table) { double('table', name: table_name, dice_to_roll: dice) }
      let(:entry) { double('entry') }
      let(:environment) { TableEntryEnvironment.new(roll, table, entry) }

      it 'knows its roll' do
        expect(environment.context.roll).to eq(roll)
      end

      it 'knows its name' do
        expect(environment.context.table_name).to eq(table_name)
      end

      it 'knows the table\'s dice' do
        expect(environment.context.dice_rolled).to eq(dice)
      end

      describe 'lookup' do
        let(:roll_to_lookup) { 77 }
        let(:lookup_entry) { double('lookup entry') }
        let(:value) { 33 }

        before(:each) do
          allow(table).to receive(:lookup) { lookup_entry }
          allow(lookup_entry).to receive(:evaluate) { value }
          @value = environment.lookup(roll_to_lookup)
        end

        it 'gets the entry from the table' do
          expect(table).to have_received(:lookup).with(roll_to_lookup)
        end

        it 'evaluates the entry' do
          expect(lookup_entry).to have_received(:evaluate).with(roll_to_lookup)
        end

        it 'returns the result from the evaluation' do
          expect(@value).to eq(value)
        end
      end

      describe 'reroll' do
        let(:value) { 19 }
        let(:strategy) { double('strategy', value: value) }

        before(:each) do
          allow(RollStrategy).to receive(:new) { strategy }
          @value = environment.reroll
        end

        it 'creates a new reroll strategy' do
          expect(RollStrategy).to have_received(:new).with(table)
        end

        it 'defers to the strategy' do
          expect(strategy).to have_received(:value)
        end

        it 'returns the strategy result' do
          expect(@value).to eq(value)
        end
      end

      describe 'reroll_and_ignore' do
        let(:value) { 19 }
        let(:rollset) { double('rollset') }
        let(:strategy) { double('strategy', value: value) }

        before(:each) do
          allow(RollAndIgnoreStrategy).to receive(:new) { strategy }
          allow(RpgLib::RollSet).to receive(:new) { rollset }
          @value = environment.reroll_and_ignore(1, 2, 3)
        end

        it 'creates a new reroll strategy' do
          expect(RollAndIgnoreStrategy).to have_received(:new).with(table, rollset)
        end

        it 'defers to the strategy' do
          expect(strategy).to have_received(:value)
        end

        it 'returns the strategy result' do
          expect(@value).to eq(value)
        end
      end

      describe 'reroll_and_ignore_duplicates' do
        let(:times) { 3 }
        let(:values) { [19, 17, 22] }
        let(:rollset) { double('rollset') }
        let(:strategy) { double('strategy', values: values) }

        before(:each) do
          allow(RollAndIgnoreDuplicatesStrategy).to receive(:new) { strategy }
          allow(entry).to receive(:roll) { roll }
          allow(RpgLib::RollSet).to receive(:new) { rollset }
          @values = environment.reroll_and_ignore_duplicates(times)
        end

        it 'creates a new reroll strategy' do
          expect(RollAndIgnoreDuplicatesStrategy).to have_received(:new).with(table, times, rollset)
        end

        it 'defers to the strategy' do
          expect(strategy).to have_received(:values)
        end

        it 'returns the strategy result' do
          expect(@values).to eq(values)
        end
      end
    end
  end
end
