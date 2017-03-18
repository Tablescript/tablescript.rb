require 'spec_helper'

module Tablescript
  describe Api do
    let(:api) { Class.new { include Api }.new }

    describe 'table' do
    end

    describe 'rolling' do
      let(:values) { %w(red green blue) }

      before(:each) do
        Library.instance = Library.new
        api.table :colours do
          f { 'red' }
          f { 'green' }
          f { 'blue' }
        end
      end

      describe 'roll_on' do
        it 'rolls on the table' do
          10.times do
            expect(values).to include(api.roll_on(:colours))
          end
        end
      end

      describe 'roll_on_and_ignore' do
        it 'rolls on the table and ignores certain rolls' do
          10.times do
            expect(%w(red blue)).to include(api.roll_on_and_ignore(:colours, 2))
          end
        end
      end

      describe 'roll_on_and_ignore_duplicates' do
        before(:each) do
          @results = []
          10.times do
            @results << api.roll_on_and_ignore_duplicates(:colours, 2)
          end
        end

        it 'returns the expected number of results' do
          @results.each do |roll_results|
            expect(roll_results.size).to eq(2)
          end
        end

        it 'ignores duplicate rolls' do
          @results.each do |roll_results|
            expect(roll_results[0]).not_to eq(roll_results[1])
          end
        end
      end

      describe 'lookup' do
        it 'returns the specified entry' do
          expect(api.lookup(:colours, 2)).to eq('green')
        end
      end
    end
  end
end
