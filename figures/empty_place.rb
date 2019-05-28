require 'singleton'
##
# Class which is a singleton representing
# the empty place on the board
class EmptyPlace < ChessFigure
  include Singleton

  def initialize
    @color = :none
  end

  ##
  # To string method
  def to_s
    "   "
  end

  def empty?
    true
  end

  def inspect
    "empty"
  end
end
