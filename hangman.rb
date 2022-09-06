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

class HumanPlayer
  attr_reader :alphabet  
  def initialize
    @alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  end

  public
  def play_round
    guess = gets.chomp
    @alphabet.delete(guess)
    guess.downcase
  end  

end

class Game

attr_reader :remaining_rounds

def initialize
@computer = Computer.new
@human_player = HumanPlayer.new
@remaining_rounds = 8
self.play_game
end

def play_game
  until @remaining_rounds == 0 || @computer.game_won == 'yes'
    puts "Guess the word! #{@computer.display_word}. You have #{@remaining_rounds} guesses left."
    puts "Choose from these letters #{@human_player.alphabet.join(', ')}"
    @remaining_rounds = @remaining_rounds - 1
    guess = @human_player.play_round
    @computer.check_word(guess)
    @computer.check_if_game_over(@remaining_rounds)
  end  
end

end

game = Game.new