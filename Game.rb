require "yaml"
class Game
  def initialize(words)
    @solution = words[rand(words.length)].split("")
    @word = []
    @guesses = 12
    @wrong_letters = []
    @all_letters = ("a".."z").to_a
  end

  def start
    puts "New game"
    puts "At any time, type 'save' to save the game or 'exit' to exit."
    @solution.length.times do
      @word.push("_")
    end
    display(@word,@wrong_letters)
    play
  end

  def play
    check(guess)
    display(@word,@wrong_letters)
    next_turn
  end

  private

  def user_input(input)
    if input == "save"
      save_game
      play
    elsif input == "exit"
      puts "Bye!"
      exit
    else
      return input
    end
  end

  def guess
    puts "Enter a letter:"
    letter = user_input(gets.chomp.downcase)
    while true
      if @all_letters.include?(letter)
        break
      elsif letter.length == 1 && letter =~ /[a-z]/
        puts "You've tried this one already, try again: "
      else
        puts "Not a letter, try again: "
      end
      letter = user_input(gets.chomp.downcase)
    end
    @guesses -= 1
    return letter
  end

  def display(word,letters)
    puts word.join(" ")
    puts "Previous wrong choices: #{letters.join(" ")}" unless letters.empty?
  end

  def check(letter)
    puts "Checking..."
    @all_letters.delete(letter)
    if @solution.include?(letter)
      puts "Found a letter!"
      indexes = @solution.length.times.select {|i| @solution[i] == letter}
      for i in indexes
        @word[i] = letter
      end
    else
      puts "Sorry, this letter doesn't appear!"
      @wrong_letters.push(letter)
    end
  end

  def next_turn
    if @word == @solution
      victory
    elsif @guesses == 0
      end_game
    else
      puts "#{@guesses} guesses left"
      play
    end
  end

  def victory
    puts "Congratulations, you found the word!"
    exit
  end

  def end_game
    puts "Sorry, you're out of guesses!"
    puts "The word was: #{@solution.join("")}"
    exit
  end

  def save_game
    puts "Enter a name so you can retrieve your saved game later:"
    filename = gets.chomp.downcase
    File.open("saved_games/#{filename}.yml", "w") do |file|
      file.write(YAML.dump(self))
    end
    puts "Game saved."
  end
end
