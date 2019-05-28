require_relative "../algorithm/chess_node"
require_relative "../algorithm/mini_max_function"

##
# Class representing the computer player usin minimax algorithm
class ComputerPlayer
  # include minimax function from a module
  include MiniMaxFunction

  # number of moves the computers looks ahead
  PREDICTION_DEPTH = 2
  attr_reader :color

  def initialize(color, display)
    @color = color
    @display = display
  end


  def get_move
    @display.draw
    # minimax algorithm may take some time - here we are thinking
    puts 'thinking...'

    root = ChessNode.new(@display.board, color)
    best_score = minimax(root, ComputerPlayer::PREDICTION_DEPTH)

    best_node = root.children.find { |node| node.value == best_score }
    best_node.previous_move
  end
end
