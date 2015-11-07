class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter.empty? 
    raise ArgumentError if letter =~ /[^(a-zA-Z)]/
    letter = letter.downcase
    if @word.include? letter
      if !@guesses.include? letter
        @guesses << letter
        return true
      else
        return false
      end
    else
      if !@wrong_guesses.include? letter
        @wrong_guesses << letter
        return true
      else
        return false
      end
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
