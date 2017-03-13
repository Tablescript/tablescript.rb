require 'spec_helper'

module Tablescript
  describe Result do
    it 'can be created' do
      expect { Result.new(:roll, :value) }.not_to raise_error
    end

    describe 'once created' do
      let(:result) { Result.new(5, 'a sword') }

      it 'knows its roll' do
        expect(result.roll).to eq(5)
      end

      it 'knows its value' do
        expect(result.value).to eq('a sword')
      end
    end
  end
end
