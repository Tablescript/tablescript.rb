# Copyright 2015 Jamie Hale
#
# This file is part of the Tablescript.rb gem.
#
# Tablescript.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Tablescript.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
    
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tablescript/version'

Gem::Specification.new do |s|
  s.name        = 'tablescript'
  s.version     = TableScript::VERSION
  s.date        = '2015-05-05'
  s.summary     = "TableScript RPG Tool"
  s.description = "Library for creating role-playing game random tables."
  s.authors     = [ 'Jamie Hale' ]
  s.email       = [ 'jamie@smallarmyofnerds.com' ]
  s.homepage    = 'http://smallarmyofnerds.com/tablescript'
  s.license     = "GPL-3.0"
  s.platform    = Gem::Platform::RUBY
  s.files       = `git ls-files -z`.split( "\x0" )
  s.require_paths = [ 'lib' ]
end
