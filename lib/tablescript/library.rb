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

module Tablescript
  ##
  # Library
  #
  class Library
    attr_reader :root

    def initialize
      @root = Namespace.new
    end

    def table(path)
      parts = path.split('/')
      return @root.resolve(path) if parts.size == 1
      return @root.resolve(parts[1..-1].join('/')) if parts[0].empty?
      @root.resolve(path)
    end

    def self.instance
      @instance ||= Library.new
    end

    class << self
      attr_writer :instance
    end
  end
end
