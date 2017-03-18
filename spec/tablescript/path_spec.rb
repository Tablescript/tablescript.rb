require 'spec_helper'

module Tablescript
  describe Path do
    describe 'join' do
      describe 'relative' do
        it 'returns a single part' do
          expect(Path.join('a')).to eq('a')
        end

        it 'joins 2 parts' do
          expect(Path.join('a', 'b')).to eq('a/b')
        end

        it 'joins 3 parts' do
          expect(Path.join('a', 'b', 'c')).to eq('a/b/c')
        end

        it 'joins 2 parts that are actually 3' do
          expect(Path.join('a', 'b/c')).to eq('a/b/c')
        end

        it 'resolves ..' do
          expect(Path.join('a/b', '../c')).to eq('a/c')
        end
      end

      describe 'absolute' do
        it 'returns a single part' do
          expect(Path.join('/a')).to eq('/a')
        end

        it 'joins 2 parts' do
          expect(Path.join('/a', 'b')).to eq('/a/b')
        end

        it 'resolves ..' do
          expect(Path.join('/a', 'b', '../c')).to eq('/a/c')
        end
      end
    end

    describe 'resolve' do
      it 'resolves a simple path' do
        expect(Path.resolve('a')).to eq('a')
      end

      it 'resolves a simple multi-part path' do
        expect(Path.resolve('a/b')).to eq('a/b')
      end

      it 'resolves ..' do
        expect(Path.resolve('a/b/../c')).to eq('a/c')
      end
    end
  end
end
