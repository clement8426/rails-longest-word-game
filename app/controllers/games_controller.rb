class GamesController < ApplicationController
  def new
    random_letters = ('a'..'z').to_a
    @letters = random_letters.sample(10)
  end

  def score
    require 'open-uri'
    require 'json'
    @word = params[:word]
    @array_letters = params[:letters]
    letters_valid = @word.downcase.chars.all? { |letter| @array_letters.include?(letter) }

    if letters_valid
      api_url = URI.parse("https://wagon-dictionary.herokuapp.com/#{@word.downcase}")
      api_response = Net::HTTP.get(api_url)
      @result = JSON.parse(api_response)
      @found = @result['found']
      @found = "You win !"
    else
      @found = "Wrong word !"
    end
  end
end
