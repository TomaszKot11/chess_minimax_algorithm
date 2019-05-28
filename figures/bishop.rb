require_relative "../movement_mechanics/slideable"

class Bishop < ChessFigure
  include Slideable

  def initialize(board, color, position)
    super(board, color, position)
    @value = 3
  end
  attr_reader :value

  def to_s
    @color == :white ? " ♗ " : " ♝ "
  end

  def move_dirs
    Slideable::DIAGONAL_DIRS
  end

  def inspect
    "♗, #{@color}, #{@position}"
  end
end
