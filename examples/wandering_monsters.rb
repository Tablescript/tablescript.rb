#! /usr/bin/env ruby

require 'tablescript'
include Tablescript::Api

require 'rpg_lib'
include RpgLib::Api

table :wandering_monsters do
  f(1..5) { "#{roll('d6')} orcs" }
  f(6..19) { "#{roll('3d6')} ancient red dragons" }
  f(20) { 'a cuddly bunny' }
end

puts roll_on(:wandering_monsters)
