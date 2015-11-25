class HangpersonGame
  
  attr_accessor :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word, @guesses, @wrong_guesses = word, '', ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError unless !letter.nil? && (/^[a-z]$/.match letter.downcase)
    letter = letter.downcase
    if (@guesses.include? letter) || (@wrong_guesses.include? letter)
      false
    elsif @word.include? letter
      @guesses << letter
      true
    else
      @wrong_guesses << letter
      true
    end
  end
  
  def word_with_guesses
    word_completed = ''
    @word.split("").each do |letter|
      if @guesses.include? letter
        word_completed << letter
      else
        word_completed << '-'
      end
    end
    word_completed
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif !word_with_guesses.include? '-'
      :win
    else
      :play
    end
  end

end
