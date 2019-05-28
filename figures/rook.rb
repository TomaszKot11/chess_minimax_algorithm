require_relative "../movement_mechanics/slideable"

##
# Class representing the rook figure
# in chess game
class Rook < ChessFigure
  include Slideable

  ##
  # Getter for the value use to calculate the minimax function
  attr_reader :value

  def initialize(board, color, position)
    super(board, color, position)
    @value = 5
  end

  def to_s
    @color == :white ? " ♖ " : " ♜ "
  end

  ##
  # method returning the matrix
  # of possible movementd directions
  def move_dirs
    Slideable::HORIZONTAL_DIRS
  end

  def inspect
    "♖, #{@color}, #{@position}"
  end
end
