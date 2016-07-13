class HumanPlayer

  attr_reader :name, :board, :size

  def initialize(name = "Human")
    @name = name
  end

  def guessed_pos(board, turn)
    @board = board
    @size = board.size
    guess = ""
    loop do
      puts "Choose a position (ex: 9,7)"
      guess = gets.chomp
      break if valid_guess?(guess) && check_reveal?(guess)
      puts "Invalid guess. Try again."
    end
    guess.split(",").map(&:to_i)
  end

  def valid_guess?(pos)
    arr = pos.split(",")
    return false unless arr.size == 2
    arr.all?  do |num|
      num !~ /\D/ && num.to_i.between?(0,size - 1)
    end
  end

  def check_reveal?(guess)
    !board[*guess.split(",").map(&:to_i)].face_up
  end

end
