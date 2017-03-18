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

require 'rpg_lib'

require 'tablescript/version'
require 'tablescript/exception'
require 'tablescript/roll_strategy'
require 'tablescript/roll_and_ignore_strategy'
require 'tablescript/roll_and_ignore_duplicates_strategy'
require 'tablescript/lookup_strategy'
require 'tablescript/table_entries'
require 'tablescript/table'
require 'tablescript/table_entry'
require 'tablescript/roll_context'

$LOAD_PATH.push File.expand_path(ENV['TS_PATH']) unless ENV['TS_PATH'].nil?

require 'tablescript/table_generator'
require 'tablescript/namespace_generator'
require 'tablescript/namespace'
require 'tablescript/library'
require 'tablescript/api'
