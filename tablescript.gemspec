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
  s.homepage    = 'http://smallarmyofnerds.com'
  s.license     = "GPL-3.0"
  s.platform    = Gem::Platform::RUBY
  s.files       = `git ls-files -z`.split( "\x0" )
  s.require_paths = [ 'lib' ]
end
