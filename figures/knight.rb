require_relative "../movement_mechanics/steppable"

##
# Class representing the knight figure
# in chess game
class Knight < ChessFigure
  include Steppable

  ##
  # Getter for the value use to calculate the minimax function
  attr_reader :value

  def initialize(board, color, position)
    super(board, color, position)
    @value = 3
  end


  def to_s
    @color == :white ? " ♘ " : " ♞ "
  end

  ##
  # method returning the matrix
  # of possible movementd directions
  def move_dirs
    [
      [2, 1],
      [1, 2],
      [-1, 2],
      [-2, 1],
      [-2, -1],
      [-1, -2],
      [1, -2],
      [2, -1]
    ]
  end

  def inspect
    "♘, #{@color}, #{@position}"
  end
end
