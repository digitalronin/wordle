class Game
  attr_reader :secret
  attr_accessor :state

  WORDS_FILE = "data/valid-words.txt"

  def initialize
    @secret = random_word
    @state = :running
    @guesses = 0
  end

  def loop
    while state == :running
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
      state = :finished
      puts "Success in #{guess_count} guesses"
    end
  end

  def quit
    puts "Exiting"
    state = :finished
  end

  def get_input
    print "> "
    gets.chomp
  end

  def random_word
    File.readlines(WORDS_FILE).sample.chomp
  end
end
