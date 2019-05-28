require_relative "../display"
##
# Class encapsulates the non-computer player logic
class HumanPlayer
  # the color of player
  attr_reader :color

  ##
  # Constructor
  # Params:
  # +color+:: the color of the player
  # +display+:: the object of a class encapsulating
  def initialize(color, display)
    @color = color
    @display = display
  end

  ##
  # method gets the player movement
  def get_move
    cols = %w(a b c d e f g h)
    rows = %w(8 7 6 5 4 3 2 1)

    from_pos, to_pos = nil, nil
    until from_pos && to_pos
      @display.draw
      if from_pos
        row, col = from_pos
        piece = @display.board[from_pos].class
        puts "#{piece} at #{cols[col]}#{rows[row]} selected. Where to move to?"
        to_pos = @display.get_keyboard_input
      else
        @display.reset_errors_notification
        puts "#{@color.capitalize}'s move"
        puts 'What piece do you want to move?'
        selection = @display.get_keyboard_input
        from_pos = selection if selection && valid_selection?(selection)
      end
    end
    [from_pos, to_pos]
  end

  ##
  # Boolean method returning the bool value indicating
  # whether the given selected figure is valid
  def valid_selection?(pos)
    piece = @display.board[pos]
    piece.color == @color
  end
end
