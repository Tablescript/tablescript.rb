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

    describe 'scopes' do
      # / + a => /a
      # /a + b => /a/b, /b
      # /a/b + c => /a/b/c, /a/c, /c
      # /any/scope + /any/path => /any/path
      # /a/b + c/d => /a/b/c/d, /a/c/d, /c/d
      # /a/b + ../c => /a/c, /c
      it 'returns a single scope from a simple path' do
        expect(Path.scopes('/', 'a')).to contain_exactly('/a')
      end

      it '' do
        expect(Path.scopes('/a', 'b')).to contain_exactly('/a/b', '/b')
      end

      it '' do
        expect(Path.scopes('/a/b', 'c')).to contain_exactly('/a/b/c', '/a/c', '/c')
      end

      it '' do
        expect(Path.scopes('/a/b/c', '/d/e/f')).to contain_exactly('/d/e/f')
      end

      it '' do
        expect(Path.scopes('/a/b', 'c/d')).to contain_exactly('/a/b/c/d', '/a/c/d', '/c/d')
      end

      it '' do
        expect(Path.scopes('/a/b', '../c')).to contain_exactly('/a/c', '/c')
      end
    end
  end
end
