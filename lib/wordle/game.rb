class Game
  attr_reader :secret

  WORDS_FILE = "data/valid-words.txt"

  def initialize
    @secret = random_word
    @state = :running
    @guesses = 0
    @eliminated_letters = []
  end

  def loop
    while @state == :running
      input = get_input

      case input
      when "q", "quit", "exit"
        quit
      when "reveal", "show"
        puts "Secret word: #{secret}"
      when /^[a-z]{5}$/
        handle_guess(input)
      else
        puts "???"
      end
    end
  end

  private

  def handle_guess(str)
    @guesses += 1
    guess = Guess.new(str.downcase, secret)
    puts guess.formatted

    if guess.correct?
      @state = :finished
      puts "Success in #{guess_count} guesses"
    else
      eliminate_letters(guess)
      puts possible_letters.join(" ").upcase
    end
  end

  def possible_letters
    (("a".."z").to_a - @eliminated_letters).sort
  end

  def eliminate_letters(guess)
    wrong_letters = guess.letters.filter { |letter| letter.status == :wrong }.map(&:char)
    @eliminated_letters = (@eliminated_letters + wrong_letters).uniq
  end

  def quit
    puts "Exiting"
    @state = :finished
  end

  def get_input
    print "> "
    gets.chomp
  end

  def random_word
    File.readlines(WORDS_FILE).sample.chomp
  end
end
