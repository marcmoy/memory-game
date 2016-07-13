require_relative 'board'
require_relative 'human'
require_relative 'computer'

class Game

  attr_reader :size, :board, :player, :turn

  def initialize(size = 10, player)
    @size = size
    @player = player
    @board = Board.new(size)
    @turn = 1
  end

  def play
    loop do
      play_turn
      break if board.won?
    end
    puts "#{player.name} wins!"
  end

  def play_turn

    board.render
    first_guess = player.guessed_pos(board, turn)
    board[*first_guess].reveal
    board.render

    @turn += 1

    sec_guess = player.guessed_pos(board, turn)
    board[*sec_guess].reveal
    board.render

    @turn += 1

    update_board(first_guess, sec_guess)
    board.render

  end

  def update_board(pos1, pos2)
    hide_two_cards(pos1, pos2) if check_two_guesses(pos1, pos2)
  end

  def hide_two_cards(pos1,pos2)
    board[*pos1].hide
    board[*pos2].hide
  end

  def check_two_guesses(pos1, pos2)
    board[*pos1].value != board[*pos2].value
  end

end

if __FILE__ == $PROGRAM_NAME
  answer = ""
  loop do
    system('clear')
    puts "Would you like to run the 'memory' game with a computer or human?"
    answer = gets.downcase.chomp
    break if ['computer','human'].include?(answer)
    puts "Not a valid answer. Try again."
    sleep(2)
  end
  player = ComputerPlayer.new('CPU') if answer == 'computer'
  player = HumanPlayer.new('Human') if answer == 'human'
  game = Game.new(10, player)
  game.play
end
