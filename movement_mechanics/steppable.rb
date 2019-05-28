
##
# Module encapsulates the movement validation for figures like pawn etc.
module Steppable

  ##
  # method checks and returns valid moves for a specific figure like a pawn
  def moves
    moves = []
    cur_x, cur_y = @position
    self.move_dirs.each do |dx, dy|
      position = cur_x + dx, cur_y + dy
      moves << position if @board.in_bounds?(position) && @board[position].color != @color
    end
    return moves
  end
end
