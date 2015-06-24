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
    
module TableScript
  
  class RollDescriptor

    attr_reader :die, :count, :drop_lowest, :drop_highest
  
    def initialize( match )
      initialize_die( match )
      initialize_count( match )
      initialize_dropped_dice( match )
    end
  
    private
  
      def initialize_die( match )
        @die = match[ 2 ].to_i
      end
    
      def initialize_count( match )
        @count = 1
        @count = match[ 1 ].to_i unless match[ 1 ].empty?
      end
    
      def initialize_dropped_dice( match )
        @drop_lowest = 0
        @drop_highest = 0
        if match[ 4 ] == "dl"
          @drop_lowest = 1
          @drop_lowest = match[ 5 ].to_i unless match[ 5 ].empty?
        elsif match[ 6 ] == "dh"
          @drop_highest = 1
          @drop_highest = match[ 7 ].to_i unless match[ 7 ].empty?
        end
      end
  
  end

end
