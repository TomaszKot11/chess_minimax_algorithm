require_relative "../movement_mechanics/slideable"

##
# Class representing the queen figure
# in chess game
class Queen < ChessFigure
  include Slideable

  ##
  # Getter for the value use to calculate the minimax function
  attr_reader :value

  def initialize(board, color, position)
    super(board, color, position)
    @value = 9
  end

  def to_s
    @color == :white ? " ♕ " : " ♛ "
  end

  def move_dirs
    Slideable::DIAGONAL_DIRS + Slideable::HORIZONTAL_DIRS
  end

  def inspect
    "♕, #{@color}, #{@position}"
  end
end
