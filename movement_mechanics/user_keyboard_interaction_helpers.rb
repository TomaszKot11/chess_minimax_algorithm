require "io/console"

##
# Module encapsulates the STDIN/STDOUT logic
module UserKeyboardInteractionHelpers
  # hash (dictionary) representing the available keys to be
  # used in the game
  KEYMAP = {
    " " => :space,
    "h" => :left,
    "j" => :down,
    "k" => :up,
    "l" => :right,
    "w" => :up,
    "a" => :left,
    "s" => :down,
    "d" => :right,
    "\t" => :tab,
    "\r" => :return,
    "\n" => :newline,
    "\e" => :escape,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\177" => :backspace,
    "\004" => :delete,
    "\u0003" => :ctrl_c,
  }
  # hash with arrays of movement
  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  ##
  # method gets STDIN and handles it
  def get_keyboard_input
    key = KEYMAP[read_char_input_and_parse]
    handle_key(key)
  end

  ##
  # Methdod handles the specific input using symbol
  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :return, :space
      @cursor_pos
    when :left, :right, :up, :down
      update_position(MOVES[key])
      nil
    else
      puts key
    end
  end

  ##
  # method reads the raw stdin and parses it
  def read_char_input_and_parse
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  ##
  #  method updates the cursor position of the main cursor
  def update_position(diff)
    new_pos = [@cursor_pos[0] + diff[0], @cursor_pos[1] + diff[1]]
    @cursor_pos = new_pos if @board.in_bounds?(new_pos)
  end
end
