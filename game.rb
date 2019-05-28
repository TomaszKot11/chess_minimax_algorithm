require_relative 'board'
require_relative 'display'
require_relative "players/human_player"
require_relative "players/computer_player"

##
# Class encapsulates the game managment and game creation
class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: ComputerPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  ##
  # Methods starts the game and loops it until
  # there is no final checkmate
  def start_game
    until @board.checkmate?(@current_player)
      begin
        from_pos, to_pos = @players[@current_player].get_move
        @board.move_figure(from_pos, to_pos)
        swap_turn!
        display_notications
      rescue StandardError => e
        @display.notifications[:error] = e.message
        retry
      end
    end
    swap_turn!
    @display.clear_check_notification
    @display.draw

    puts 'Checkmate!'
    puts "#{@current_player.capitalize} wins"
  end

  private

  ##
  # Methods responsible for displaying all notfication
  def display_notications
    if @board.in_check?(@current_player)
      @display.set_check_notification
    else
      @display.clear_check_notification
    end
  end

  def swap_turn!
    @current_player = @current_player == :white ? :black : :white
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.start_game
end
