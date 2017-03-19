# Tablescript.rb

This is a Ruby gem that helps RPG-playing nerds like me generate random things from tables.

For example, a Dungeons & Dragons wandering monster table like this:

    Wandering Monsters (d10):
    
    1-5: d6 orcs
    6-19: 3d6 ancient red dragons
    20: a cuddly bunny

can be automated in Ruby-ish ways like this:

    table :wandering_monsters do
      f(1..5) { "#{roll('d6')} orcs" }
      f(6..19) { "#{roll('3d6')} ancient red dragons" }
      f { "a cuddly bunny" }
    end
    
    puts roll_on(:wandering_monsters)

# Syntax

Tablescript.rb is a simple DSL built on Ruby that helps to define and roll on tables.

Define a table as follows:

    table :table_name do
      ...
    end

Roll on a table as follows:

    roll_on(:table_name)

Table entries define blocks that are returned if the die roll matches the entry. Entries can be simple text:

    f { "a cuddly bunny" }

complex/interpolated text:

    f { "#{roll('3d6')} cuddly bunnies" }

or arbitrary Ruby code:

    f { { effect: roll_on(:random_limb_loss), damage: roll('4d10') }

Table entries are either "f" or "d" for "fixed" and "dynamic" respectively.

Fixed entries are defined for specify die rolls. For example:

    f(1) { ... }

defines the result for the roll of 1.

    f(5..9) { ... }

defines the result for a roll of 5, 6, 7, 8, or 9.

    f { ... }

defines the result for the _next_ roll. If it's the first entry, it defaults to 1. Otherwise, it's whatever the previous entry was + 1.

The :wandering\_monsters example table above defines 3 entries: 1-5, 6-9, and 10.

Dynamic entries are defined for groups of rolls. For example:

    d(10) { ... }
    d(50) { ... }
    d(40) { ... }

defines 3 groups of results. The first is for rolls of 1-10 (i.e. the first 10). The second is for rolls of 11-60 (i.e. the next 50). And the third is for rolls of 51-100 (i.e. the next 40). In this case the total number of entries works out to 100, so the entries are effectively 10%, 50%, and 40%.

Entries do not have to total 100. For example:

    d(1) { ... }
    d(2) { ... }

defines 2 groups of results where the second has twice the chance of the first. Tablescript will effectively roll a d3.

# Reference

Include the Tablescript API into your global namespace as follows:

    include Tablescript::Api

The Tablescript API includes the following global functions:

## namespace(name, &blk)

Defines a namespace. Namespaces can contain other namespaces, and tables.

## table(name, &blk)

Defines a table, as in the above examples. Tables defined inside a namespace are accessible in that namespace, or by providing an absolute (/path/to/table) or relative (path/to/table or ../path/to/table) path. See the examples.

## roll\_on(name)

Generates a random number from 1 to the highest defined entry, and returns the corresponding table entry -- evaluated -- from table named _name_.

## roll\_on\_and\_ignore(name, \*args)

Rolls on the _name_ table and ignores rolls that match the passed arguments. For example:

    roll_on_and_ignore(:wandering_monsters, 1..5)

will roll until it gets something other than orcs.

    roll_on_and_ignore(:wandering_monsters, 1..5, 10)

will only return ancient red dragons.

## roll\_on\_and\_ignore\_duplicates(name, times)

Rolls on the _name_ table _times_ times and ignores duplicate entries.

## lookup(name, roll)

Returns the entry from table _name_ corresponding to the roll _roll_ as if that number had been randomly generated.

# Installation

    $> gem install tablescript

Include Tablescript:

    require 'tablescript'
    include Tablescript::Api

The include is optional. You can use the Tablescript library directly, or in another namespace if you so choose.

# Development

Tablescript runs in Ruby 2.4. It hasn't been tested in previous versions.

    $> rake spec
    $> rake rubocop
