require 'colorize'

class Card

  attr_reader :value
  attr_accessor :face_up
  def initialize(value)
    @value = value
    @face_up = false
  end

  def to_s
    @face_up ? formated_value : "XX".colorize(:light_blue)
  end

  def formated_value
    value.to_s.rjust(2,'0').colorize(:red)
  end

  def reveal
    @face_up = true
  end

  def hide
    @face_up = false
  end

end
