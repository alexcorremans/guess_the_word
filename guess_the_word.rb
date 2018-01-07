require_relative 'Game'

all_words = File.readlines("5desk.txt").map {|line| line.chomp}
words = Array.new
all_words.each do |word|
  words.push(word.downcase) if word.length.between?(5,12)
end

puts "Are you ready to guess the word?"
puts "Type 'new' to play a new game or 'saved' to open a previously saved game"
choice = gets.chomp.downcase
until choice == "new" || choice == "saved"
  puts "Not a valid choice, choose 'new' or 'saved':"
  choice = gets.chomp.downcase
end
if choice == "new"
  Game.new(words).start
else
  game = YAML.load_file("saved_game.yml")
  game.play
end
