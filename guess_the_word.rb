require_relative 'Game'

all_words = File.readlines("5desk.txt").map {|line| line.chomp}
words = Array.new
all_words.each do |word|
  words.push(word.downcase) if word.length.between?(5,12)
end

Game.new(words).start
