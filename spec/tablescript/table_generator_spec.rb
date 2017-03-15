require 'spec_helper'

module Tablescript
  describe TableGenerator do
    it 'can be created' do
      expect { TableGenerator.new }.not_to raise_error
    end

    describe 'once created' do
      let(:generator) { TableGenerator.new }

      it 'has no entries' do
        expect(generator.entries).to be_empty
      end
    end

    describe 'dynamic' do
      let(:blk) { proc { 71 } }
      let(:generator) { TableGenerator.new }

      describe 'single' do
        before(:each) do
          generator.d(&blk)
          @entry = generator.entries[0]
        end

        it 'adds 1 entry' do
          expect(generator.entries.size).to eq(1)
        end

        it 'adds with id 0' do
          expect(@entry.id).to eq(0)
        end

        it 'adds with roll 1..1' do
          expect(@entry.roll).to eq(1..1)
        end

        it 'adds with the correct blk' do
          expect(@entry.blk).to eq(blk)
        end
      end

      describe 'multiples' do
        before(:each) do
          generator.d(3, &blk)
          @entry = generator.entries[0]
        end

        it 'adds 3 entries' do
          expect(generator.entries.size).to eq(3)
        end

        it 'adds 3 references to the same entry' do
          expect(generator.entries[1]).to eq(@entry)
          expect(generator.entries[2]).to eq(@entry)
        end

        it 'adds with id 0' do
          expect(@entry.id).to eq(0)
        end

        it 'adds with roll 1..3' do
          expect(@entry.roll).to eq(1..3)
        end

        it 'adds with the correct blk' do
          expect(@entry.blk).to eq(blk)
        end
      end
    end

    describe 'fixed' do
      let(:blk) { proc { 17 } }
      let(:generator) { TableGenerator.new }

      describe 'single' do
        before(:each) do
          generator.f(&blk)
          @entry = generator.entries[0]
        end

        it 'adds single entry' do
          expect(generator.entries.size).to eq(1)
        end

        it 'adds with id 0' do
          expect(@entry.id).to eq(0)
        end

        it 'adds with roll 1' do
          expect(@entry.roll).to eq(1)
        end

        it 'adds with correct block' do
          expect(@entry.blk).to eq(blk)
        end
      end

      describe 'integer' do
        before(:each) do
          generator.f(5, &blk)
          @entry = generator.entries[4]
        end

        it 'adds single entry but all 4 prior are empty' do
          expect(generator.entries.size).to eq(5)
        end

        it 'adds 4 empty entries' do
          0.upto(3) do |i|
            expect(generator.entries[i]).to be_nil
          end
        end

        it 'adds with id 0' do
          expect(@entry.id).to eq(0)
        end

        it 'adds with roll 5' do
          expect(@entry.roll).to eq(5)
        end

        it 'adds with correct block' do
          expect(@entry.blk).to eq(blk)
        end
      end

      describe 'range' do
        before(:each) do
          generator.f(3..5, &blk)
          @entry = generator.entries[2]
        end

        it 'adds 3 entries but has 2 empty ones' do
          expect(generator.entries.size).to eq(5)
        end

        it 'has 2 empty entries' do
          expect(generator.entries[0]).to be_nil
          expect(generator.entries[1]).to be_nil
        end

        it 'has 3 references to the entry' do
          expect(@entry).to eq(generator.entries[3])
          expect(@entry).to eq(generator.entries[4])
        end

        it 'adds with id 0' do
          expect(@entry.id).to eq(0)
        end

        it 'adds with roll 3..5' do
          expect(@entry.roll).to eq(3..5)
        end

        it 'adds with the correct blk' do
          expect(@entry.blk).to eq(blk)
        end
      end

      describe 'invalid types' do
        it 'throws if passed a non-integer, non-range, non-nil parameter' do
          expect { generator.f('string', &blk) }.to raise_error(Exception)
        end
      end
    end
  end
end
