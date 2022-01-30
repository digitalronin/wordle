#!/usr/bin/env ruby

# Extract all 5-letter words with no repeated letters

LENGTH = 5

def passes_filter(line)
  word = line.chomp
  word.length == LENGTH ? no_repeated_letters(word) : false
end

def no_repeated_letters(word)
  word.split('').uniq.length == word.length ? word : false
end

while line = gets
  if word = passes_filter(line)
    puts word
  end
end
