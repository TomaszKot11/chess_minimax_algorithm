require_relative "../movement_mechanics/steppable"
##
# Class representing the king figure in our game
class King < ChessFigure
  include Steppable

  ##
  # Getter for the value use to calculate the minimax function
  attr_reader :value

  def initialize(board, color, position)
    super(board, color, position)
    @value = 10
  end


  def to_s
    @color == :white ? " ♔ " : " ♚ "
  end

  ##
  # method returning the matrix
  # of possible movementd directions
  def move_dirs
    [
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
      [0, -1],
      [1, -1]
    ]
  end

  def inspect
    "♔, #{@color}, #{@position}"
  end
end
