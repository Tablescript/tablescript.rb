#! /usr/bin/env ruby

require 'tablescript'
include Tablescript::Api

namespace :utils do
  namespace :special do
    table :things do
      f { 'lamp' }
      f { 'coin' }
      f { 'tapestry' }
    end
  end

  table :colours do
    f { 'red' }
    f { 'green' }
    f { 'black' }
    f { 'blue' }
  end

  table :things do
    f { 'carpet' }
    f { 'chair' }
    f { roll_on('special/things') }
  end
end

table :stuff do
  f { "a #{roll_on('/utils/colours')} #{roll_on('/utils/things')}" }
end

puts roll_on(:stuff)
