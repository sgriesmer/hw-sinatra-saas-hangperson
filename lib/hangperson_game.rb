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
    s = "-"
    @word_with_guesses = s.center(@word.length,s)
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter.empty? 
    raise ArgumentError if letter =~ /[^(a-zA-Z)]/
    letter = letter.downcase
    if @word.include? letter
      if !@guesses.include? letter
        @guesses << letter
        self.search_and_replace(letter)
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
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :play if @word_with_guesses.include? '-'
    return :win
  end
  
  def word_with_guesses
    @word_with_guesses
  end
  
  def search_and_replace(letter)
    n = 0
    while (n = @word.index(letter,n))
      @word_with_guesses[n] = letter
      n += 1
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
