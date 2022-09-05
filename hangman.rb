class Hangman
  attr_accessor :secret_word

  def initialize
    @alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    @secret_word = 
      game_words_array = []
      f = File.open('dictionary.txt', 'r')
      f.each do |word|
        word_length = word.length
        case word_length 
        when 0..4, 13.. 
          nil
        else
          game_words_array.push(word.chomp)
        end
      end
      @secret_word = game_words_array.sample
  end  
  

 # puts "You have #{} guesses left!"
 # puts 'You win!'
 # puts 'You lose!'

 # puts @alphabet.join(', ')
end

class HumanPlayer


end

game = Hangman.new

p game.secret_word


