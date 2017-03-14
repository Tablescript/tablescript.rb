require 'spec_helper'

module Tablescript
  describe TableEntry do
    it 'can be created' do
      expect { TableEntry.new(:id, :roll, :blk) }.not_to raise_error
    end

    describe 'once created' do
      let(:entry) { TableEntry.new(:id, :roll, :blk) }

      it 'knows its id' do
        expect(entry.id).to eq(:id)
      end

      it 'knows its roll' do
        expect(entry.roll).to eq(:roll)
      end
    end

    describe 'evaluate' do
      let(:roll) { 5 }
      let(:blk) { Proc.new { 99 } }
      let(:table) { double('table') }
      let(:environment) { double('environment') }
      let(:entry) { TableEntry.new(:id, roll, blk) }

      before(:each) do
        allow(environment).to receive(:instance_eval) { 99 }
      end

      it 'defers to the environment for evaluation' do
        entry.evaluate(roll, table, environment)
        expect(environment).to have_received(:instance_eval)
      end
    end
  end
end
