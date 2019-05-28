##
# Base class for all chess figures and places
# on the board
class ChessFigure
  # getters/setters
  attr_reader :board, :color
  attr_accessor :position

  ##
  # Initializes the chess shape
  # Params:
  # +board+:: the chess board
  # +color+:: the color of a figure
  # +position+:: the position of a figure
  def initialize(board, color, position)
    @board = board
    @color = color
    @position = position
  end

  ##
  # Method determines if the the chess figure (also chessboard squares) are empty
  def empty?
    false
  end

  def valid_moves
    self.moves.reject do |move|
      board.move_into_check?(position, move, color)
    end
  end
end
