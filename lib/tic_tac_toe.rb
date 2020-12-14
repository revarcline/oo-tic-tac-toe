# got the whole game in its handa
class TicTacToe
  WIN_COMBINATIONS = [
    # horiz
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    # diag
    [0, 4, 8], [6, 4, 2],
    # vert
    [0, 3, 6], [1, 4, 7], [2, 5, 8]
  ].freeze

  def initialize
    @board = [' '] * 9
  end

  def display_board
    puts [" #{@board[0]} | #{@board[1]} | #{@board[2]} ",
          '-----------',
          " #{@board[3]} | #{@board[4]} | #{@board[5]} ",
          '-----------',
          " #{@board[6]} | #{@board[7]} | #{@board[8]} "].join("\n") + "\n"
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0, 8)
  end

  def turn_count
    @board.count { |space| space != ' ' }
  end

  def current_player
    turn_count.odd? ? 'O' : 'X'
  end

  def turn
    puts 'Please enter a number (1-9):'
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      player = current_player
      move(index, player)
    else
      turn
    end
    display_board
  end

  def won?
    WIN_COMBINATIONS.any? do |wins|
      if position_taken?(wins[0]) && @board[wins[0]] == @board[wins[1]] && @board[wins[1]] == @board[wins[2]]
        return wins
      end
    end
  end

  def full?
    @board.all? { |space| space != ' ' }
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    win = won?
    @board[win[0]] if win
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end
