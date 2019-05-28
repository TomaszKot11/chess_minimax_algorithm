require_relative 'figures'

##
# Class representing the chess board
class Board
  ##
  # getter for the place matrix
  attr_reader :rows

  ##
  # Constructor in which we are filling the board
  def initialize(fill_board = true)
    place_figures(fill_board)
  end

  ##
  # overloaded [] (getter) operator for board
  # to access board position matrix
  # with it
  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  ##
  # overloaded [] (setter) operator for borad
  # for setting the values inside the position
  # matrix
  def []=(pos, figure)
    x, y = pos
    @rows[x][y] = figure
  end

  ##
  # Performs the movement of the
  # figure in the chess game
  def move_figure(from_pos, end_pos)
    # get the figure from given position
    piece = self[from_pos]

    raise "That's not a valid move!" unless piece.moves.include?(end_pos)
    raise "Can't leave King in Check!" if move_into_check?(from_pos, end_pos, piece.color)

    #
    self[end_pos] = piece
    # make the empty figure in previous place
    self[from_pos] = EmptyPlace.instance
    # update the figure position
    piece.position = end_pos

    promote_pawn!(piece) if piece.is_a?(Pawn) && second_color_row?(end_pos)
  end

  ##
  # method checks if any of the
  # figures with given color perfrom
  # the check
  def checkmate?(color)
    in_check?(color) && figures_by_color(color).all? do |piece|
      piece.valid_moves.empty?
    end
  end

  ##
  # method checks if given color of figures
  # is in check
  def in_check?(color)
    figures.any? do |piece|
      piece.color != color && piece.moves.any? { |pos| self[pos].is_a?(King) }
    end
  end

  def inspect
    rows.map do |row|
      row.map { |piece| piece.to_s }.join("")
    end.join("\n")
  end

  ##
  # Selects only non-empty figures
  # from the board
  def figures
    @rows.flatten.reject { |piece| piece.empty? }
  end

  ##
  # method slects from the collections of figures
  # figures with given
  # +color+:: the figures color
  def figures_by_color(color)
    figures.select { |piece| piece.color == color }
  end

  def in_bounds?(pos)
    pos.all? {|coord| coord.between?(0,7)}
  end

  ##
  # check if the given position on the board
  # is empty of occupied
  def empty?(pos)
    self[pos].empty?
  end

  ##
  # Makes the copy of board and returns it
  #
  def dup
    duped_board = Board.new(false)

    figures.each do |piece|
      duped_board[piece.position] = piece.class.new(duped_board, piece.color, piece.position.dup)
    end

    duped_board
  end

  ##
  # Method checks if
  def move_into_check?(from_pos, end_pos, color)
    duped_board = self.dup

    piece = duped_board[from_pos]
    duped_board[from_pos] = EmptyPlace.instance
    duped_board[end_pos] = piece
    piece.position = end_pos

    duped_board.in_check?(color)
  end

  private

  ##
  # method checks if the given row
  # is the second row of each color
  def second_color_row?(pos)
    pos[0] == 0 || pos[0] == 7
  end

  ##
  # promotes the pawn to the queen
  def promote_pawn!(piece)
    return unless piece.is_a?(Pawn)

    self[piece.position] = Queen.new(self, piece.color, piece.position)
  end

  # ===================================================================
  # Methods responsible for setting up the whole game figures in the
  # right order
  # ===================================================================

  ##
  # Performs the whole figure placing operation
  def place_figures(fill_board)
    @rows = Array.new(8) { Array.new(8) { EmptyPlace.instance } }
    return unless fill_board

    place_second_color_rows
    place_pawn_first_rows
  end

  ##
  # Method responsibke for back row figure
  # placing
  def place_second_color_rows
    back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    [[0, :black], [7, :white]].each do |row, color|
      back_pieces.each_with_index do |piece_class, col|
        self[[row, col]] = piece_class.new(self, color, [row, col])
      end
    end
  end

  ##
  # Method responsible for first row (pawn rows) placing
  def place_pawn_first_rows
    8.times { |col| self[[1, col]] = Pawn.new(self, :black, [1, col]) }
    8.times { |col| self[[6, col]] = Pawn.new(self, :white, [6, col]) }
  end

end
