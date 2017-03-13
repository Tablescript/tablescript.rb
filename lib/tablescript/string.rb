# Copyright 2015 Jamie Hale
#
# This file is part of the Tablescript gem.
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
# along with Tablescript.  If not, see <http://www.gnu.org/licenses/>.

##
# String Patch
#
class String
  def roll
    Tablescript::DiceRoller.new.roll(self)
  end

  def roll_and_ignore(*args)
    Tablescript::DiceRoller.new.roll_and_ignore(self, Tablescript::RollSet.new(*args))
  end
end
