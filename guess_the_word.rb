require_relative 'Game'

all_words = File.readlines("5desk.txt").map {|line| line.chomp}
words = Array.new
all_words.each do |word|
  words.push(word.downcase) if word.length.between?(5,12)
end

puts "Are you ready to guess the word?"
if Dir["saved_games/*"].empty?
  Game.new(words).start
else
  puts "Type 'new' to play a new game or 'saved' to open a previously saved game"
  choice = gets.chomp.downcase
  until choice == "new" || choice == "saved"
    puts "Not a valid choice, choose 'new' or 'saved':"
    choice = gets.chomp.downcase
  end
  if choice == "new"
    Game.new(words).start
  else
    puts "What name did you save your game as?"
    begin
      filename = gets.chomp.downcase
      game = YAML.load_file("saved_games/#{filename}.yml")
      game.play
    rescue
      puts "No saved files with that name. Try again:"
      retry
    end
  end
end
