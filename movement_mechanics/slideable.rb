
##
# Module encapsulates the movement logic for such figures like knight
module Slideable
  HORIZONTAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ]

  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]


  ##
  # Method calculates the moves
  def moves
    moves = []
    self.move_dirs.each do |dx, dy|
      moves.concat(grow_unblocked_moves_in_dir(dx, dy))
    end

    moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    cur_x, cur_y = @position
    moves = []

    loop do
      cur_x, cur_y = cur_x + dx, cur_y + dy
      pos = [cur_x, cur_y]

      break unless board.in_bounds?(pos)

      if board.empty?(pos)
        moves << pos
      else
        moves << pos if board[pos].color != color
        break
      end
    end
    moves
  end
end
