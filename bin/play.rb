#!/usr/bin/env ruby

# Play a round of wordle

require_relative("../lib/wordle")

WORDS_FILE = "data/valid-words.txt"

def random_word(file)
  File.readlines(file).sample.chomp
end

secret = random_word(WORDS_FILE)

running = true
guess_count = 0

while running
  print "> "
  input = gets.chomp
  case input
  when "q", "quit", "exit"
    puts "Exiting"
    running = false
  when "reveal", "show"
    puts "Secret word: #{secret}"
  when /^[a-z]{5}$/
    guess_count += 1
    guess = Guess.new(input.downcase, secret)
    puts guess.formatted
    if guess.correct?
      running = false
      puts "Success in #{guess_count} guesses"
    end
  end
end
