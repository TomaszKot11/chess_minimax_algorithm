
#TODO: extract pawn movement logic to separate file
##
# Class representing the pawn figure in our game
class Pawn < ChessFigure
  ##
  # Getter for the value use to calculate the minimax function
  attr_reader :value

  def initialize(board, color, position)
    super(board, color, position)
    @value = 1
  end

  def to_s
    @color == :white ? " ♙ " : " ♟ "
  end

  ##
  # method returning the matrix
  # of possible movementd directions
  def move_dirs
    one_step = @color == :white ? [-1, 0] : [1, 0]
    two_step = @color == :white ? [-2, 0] : [2, 0]

    first_move? ? [one_step, two_step] : [one_step]
  end


  def attack_dirs
    @color == :white ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end

  def attack_moves
    moves = []
    attack_dirs.each do |dx, dy|
      cur_x, cur_y = @position
      position = cur_x + dx, cur_y + dy
      moves << position if valid_attack_pos?(position)
    end
    moves
  end

  def valid_attack_pos?(position)
    @board.in_bounds?(position) && !@board.empty?(position) && @board[position].color != @color
  end

  def forward_moves
    cur_x, cur_y = @position
    moves = []
    move_dirs.each do |dx, dy|
      position = cur_x + dx, cur_y + dy
      moves << position if @board.empty?(position)
    end
    moves
  end

  def first_move?
    (@position[0] == 6 && @color == :white) || (@position[0] == 1 && @color == :black)
  end

  def moves
    forward_moves + attack_moves
  end

  def inspect
    "♙, #{@color}, #{@position}"
  end
end
