# Represents a single letter in the result of a wordle guess.
class Letter
  attr_reader :char, :status

  def initialize(char, status)
    @char = char
    @status = status
  end

  def formatted
    case status
    when :correct
      correct(char)
    when :wrong
      wrong(char)
    when :wrong_pos
      wrong_pos(char)
    else
      raise "Unknown status #{status} for char #{char}"
    end
  end

  private

  def correct(str)
    # Bold white text on green background
    coloured(37, 42, str)
  end

  def wrong(str)
    # Bold white text on grey background
    coloured(37, 47, str)
  end

  def wrong_pos(str)
    # Bold yellow text on black background
    coloured(33, 40, str)
  end

  def coloured(fg, bg, str)
    "\e[1;#{fg};#{bg}m#{str}\e[0m"
  end
end
