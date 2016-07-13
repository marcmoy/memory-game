require_relative 'card'

class Board
  attr_accessor :grid, :cards, :size

  def initialize(size = 10)
    @size = size
    @grid = Array.new(size){Array.new(size)}
    populate
  end

  # private

  def populate
    define_cards
    grid.each_with_index do |row, i|
      row.each_index do |j|
        grid[i][j] = @cards.shift
      end
    end
  end

  def define_cards
    @cards = []
    (size ** 2 / 2).times do |value|
      2.times{ @cards << Card.new(value + 1) }
    end
    @cards.shuffle!
  end

  def render
    sleep(1)
    system('clear')
    divider = ""
    (size * 3 - 1).to_i.times{ divider << "-"}

    grid.each_with_index do |row, i|
      puts "#{row.collect{|card| card.to_s.rjust(2,"0")}.join("|")}"
      puts divider unless i == grid.size - 1
    end
  end

  def won?
    grid.flatten.all?{|card| card.face_up}
  end

  def reveal(guessed_pos)
    x, y = *guessed_pos
    grid[x][y].reveal
  end

  def [](*pos)
    row, col = pos
    grid[row][col]
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.render
  p board.won?
end
