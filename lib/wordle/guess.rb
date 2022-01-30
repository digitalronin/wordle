# A user's guess as to what the target word is
class Guess
  attr_reader :letters, :secret

  def initialize(str, secret)
    @secret = secret
    @letters = letter_results(str)
  end

  def formatted
    @letters.map(&:formatted).join
  end

  private

  def letter_results(str)
    rtn = []
    str.split("").each_with_index do |char, i|
      rtn.push(Letter.new(char.upcase, status(char, i)))
    end

    rtn
  end

  def status(char, pos)
    if char.downcase == secret[pos]
      :correct
    else
      secret.include?(char) ? :wrong_pos : :wrong
    end
  end
end
