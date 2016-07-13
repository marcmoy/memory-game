require_relative 'board'

class ComputerPlayer

  attr_reader :board, :name, :guesses, :first_guess, :second_guess, :turn, :match, :past_guesses

  def initialize(name= "CPU")
    @name = name
    @guesses = Hash.new { |h,k| h[k] = [] }
    @past_guesses = []
  end

  def guessed_pos(board, turn)
    @board = board
    @turn = turn
    if turn.odd?
      make_first_guess
    else
      make_second_guess
    end
  end

  def make_first_guess
    @match = false
    if first_best_guess_available?
      guess = first_guess
    else
      guess = random_guess
    end
    update_guesses(guess)
    @first_guess = guess
  end

  def make_second_guess
    if match
      guess = second_guess
    else
      guess = random_guess
    end
    update_guesses(guess)
    guess
  end

  def first_best_guess_available?
    guesses.each do |card,list_of_pos|
      if list_of_pos.size == 2 && !past_guesses.include?(card)
        @first_guess = list_of_pos[0]
        @second_guess = list_of_pos[1]
        @past_guesses << card
        @match = true
        return true
      end
    end
    false
  end

  def update_guesses(guess)
    card = board[*guess].value #i.e. 1
    pos = guess #i.e. [1,1]
    @guesses[card] << pos unless @guesses[card].include?(pos)
  end

  def random_guess
    available_pos.sample
  end

  def available_pos
    cards_hidden = hidden_cards_pos
    untouched_cards = cards_hidden - (guesses.values.flatten(1) & cards_hidden)
  end

  def hidden_cards_pos
    hidden_cards = []
    board.grid.each_with_index do |row, i_r|
      row.each_with_index do |card, i_c|
        hidden_cards << [i_r, i_c] unless card.face_up
      end
    end
    hidden_cards
  end

end
