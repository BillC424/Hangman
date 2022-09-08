require 'yaml'

#Class for generating secret word, updating word that displays to Human Player, and determining if guess is correct

class Computer
  attr_accessor :display_word 
  attr_reader :game_won

  def initialize
    @secret_word = 
      game_words = []
      f = File.open('dictionary.txt', 'r')
      f.each do |word|
        word_length = word.length
        case word_length 
        when 0..4, 13.. 
          nil
        else
          game_words.push(word.chomp)
        end
      end
      @secret_word = game_words.sample
    @display_word = @secret_word.gsub(/[a-z]/, '_')
    @game_won = ''
  end  
  
  public

  def check_word(letter_guess)
    secret_word_array = @secret_word.split(//)
    display_word_array = @display_word.split(//)
    secret_word_array.each_with_index do |letter, index|
      if letter == letter_guess
        display_word_array[index] = secret_word_array[index]
        @display_word = display_word_array.join
      end
    end
  end

  def check_if_game_over(remaining_rounds)
    if @display_word == @secret_word
      @game_won = 'yes'
      puts "You win! The secret word was #{@secret_word}. You get.... a brand new Hyundai Sonata! *plays Wheel of Fortune theme*"
    elsif remaining_rounds == 0
     puts "You lose. The secret word was #{@secret_word}."
    end
  end
  
end

#Class for receiving input from human player for guesses
class HumanPlayer
  attr_reader :alphabet  
  def initialize
    @alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  end

  public

  def play_round
    guess = gets.chomp.downcase
    guess = duplicate_letter_non_alphabet_check(guess)
    @alphabet.delete(guess)
    guess
  end  


  def duplicate_letter_non_alphabet_check(guess)
    if guess == 'save' 
     return guess
    end
    until ('a'..'z').include?(guess) 
      puts "#{guess} is not a letter in the alphabet. Please pick a letter."
      guess = gets.chomp
    end
    until @alphabet.include?(guess)
        puts "#{guess} has already been chosen. Please pick a different letter."
        guess = gets.chomp
    end
    guess
  end

end

#Class for determining flow of game 
class Game

attr_reader :remaining_rounds

def initialize
@computer = Computer.new
@human_player = HumanPlayer.new
@remaining_rounds = 10
self.play_game
end

def play_game
  until @remaining_rounds == 0 || @computer.game_won == 'yes'
    if @remaining_rounds == 10
      puts 'Enter yes if you want to open a saved game. Press enter to start a new game.'
      choice = gets.chomp.downcase
      Game.load_game(choice)
      break if choice == 'yes'
    end
    puts "Guess the word by picking a letter! #{@computer.display_word}. If you want to save, enter save. You have #{@remaining_rounds} guesses left."
    puts "Choose from these letters #{@human_player.alphabet.join(', ')}"
    guess = @human_player.play_round
    if guess != 'save'
      @remaining_rounds = @remaining_rounds - 1
    end
    @computer.check_word(guess)   
    @computer.check_if_game_over(@remaining_rounds)
    save_game(guess)
  end  
end

def save_game(player_input)
  if player_input == 'save'
    yaml = YAML::dump(self)
    game_file = File.new("saved.yaml", "w")
    game_file.write(yaml)
  end
end

def self.load_game(choice)
  if choice == 'yes'
    game_file = File.open("saved.yaml", "r")
    game = YAML::safe_load(game_file.read, permitted_classes: [Game, Computer, HumanPlayer])
    game.play_game
  end
end

end

game = Game.new

