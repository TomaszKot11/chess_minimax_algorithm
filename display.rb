require 'colorize'
require_relative "./movement_mechanics/user_keyboard_interaction_helpers"

##
# Class encapsulates the display logic using colorize gem
# {Colorize gem}[https://github.com/fazibear/colorize]
class Display
  include UserKeyboardInteractionHelpers

  attr_reader :board, :notifications

  def initialize(board)
    @board = board
    # current cursor position
    @cursor_pos = [6,4]
    @notifications = {}
  end

  ##
  # Method draws whole chessboard
  def grid_builder
    @board.rows.map.with_index do |row, i|
      single_row_builder(row, i)
    end
  end

  ##
  # Method draws the row using given color
  # using colorize gem
  def single_row_builder(row, i)
    row.map.with_index do |piece, j|
      color_options = color_for_square(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  ##
  # Method returns the proper color for
  # given square in the grid
  def color_for_square(i, j)
    if [i, j] == @cursor_pos
      background_color = :yellow
    elsif (i + j).odd?
      background_color = :light_white
    else
      background_color = :light_black
    end
    { color: :black, background: background_color }
  end

  ##
  # Method draw the whole chessboard (used to show movements)
  def draw
    # execute system clear function to clear the screen
    system('clear')
    puts 'WASD or Arrow keys to move, [SPACE] to confirm selection/movement'

    row_notation = %w(8 7 6 5 4 3 2 1)
    grid_builder.each_with_index do |row, i|
      puts row_notation[i].colorize(:red) + row.join
    end
    puts "  a  b  c  d  e  f  g  h".colorize(:red)

    # print all enqueued notifications
    @notifications.each do |key, val|
      puts val
    end
  end

  ##
  # Method sets the notification that check occured
  def set_check_notification
    @notifications[:check] = 'Check!'
  end

  ##
  # Method deletes the check notification message
  def clear_check_notification
    @notifications.delete(:check)
  end

  ##
  # Method deletes all errors from the notifications
  def reset_errors_notification
    @notifications.delete(:error)
  end
end
