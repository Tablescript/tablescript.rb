# Copyright 2017 Jamie Hale
#
# This file is part of the Tablescript gem.
#
# Tablescript is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Tablescript is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Tablescript.  If not, see <http://www.gnu.org/licenses/>.

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tablescript/version'

Gem::Specification.new do |spec|
  spec.name        = 'tablescript'
  spec.version     = Tablescript::VERSION
  spec.date        = '2015-05-05'
  spec.summary     = 'TableScript RPG Tool'
  spec.description = 'Library for creating role-playing game random tables.'
  spec.authors     = ['Jamie Hale']
  spec.email       = ['jamie@smallarmyofnerds.com']
  spec.homepage    = 'http://smallarmyofnerds.com/tablescript'
  spec.license     = 'GPL-3.0'
  spec.platform    = Gem::Platform::RUBY
  spec.files       = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.add_dependency 'rpg_lib', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'simplecov', '~> 0.13'
  spec.add_development_dependency 'rubocop', '~> 0.47'
end
