class Game
  def initialize(words)
    @solution = words[rand(words.length)]
    @word = []
    @solution.length.times do
      @word.push("_")
    end
    @guesses = 9
    @wrong_letters = []
  end

  def start
    puts "New game"
    display(@word,@wrong_letters)
    play
  end

  private

  def play
    check(guess)
    display(@word,@wrong_letters)

  end

  def guess
    puts "Enter a character:"
    letter = gets.chomp.downcase
    #need a while loop to check for correct input
    @guesses -= 1
    return letter
  end

  def display(word,letters)
    puts word.join(" ")
    puts "Previous wrong choices: #{letters.join(" ")}" unless letters.empty?
    puts "#{@guesses} guesses left"
  end

  def check(letter)
    puts "Checking..."
    # if the letter is in the word, add it to the @word list
    # if it's not, add it to @wrong_letters so it can be displayed

  end

  def next_turn


  end

  def end_game?



  end

end

all_words = File.readlines("5desk.txt").map {|line| line.chomp}
words = Array.new
all_words.each do |word|
  words.push(word) if word.length.between?(5,12)
end
Game.new(["programming"]).start
# Game.new(words).start

=begin

ask for a letter guess
then:
- check if it's a letter and not already chosen
- case insensitive so make sure to downcase the input
- remove the guess from the list of possible letters to choose from



reply:
- display the word
- display remaining guesses & any incorrect letters already chosen
-

end of the game:
- out of guesses
- found the word
=end
