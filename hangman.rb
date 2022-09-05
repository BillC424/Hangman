f = File.open('dictionary.txt', 'r')
game_words = []

f.each do |word|
  word_length = word.length
  case word_length 
  when 0..4, 13.. 
    nil
  else
    game_words.push(word)
  end
end

secret_word = game_words.sample

puts secret_word
