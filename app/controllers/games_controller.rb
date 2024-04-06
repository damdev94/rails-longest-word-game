require 'rest-client'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []

    10.times do
      @letters << ('a'..'z').to_a.sample
    end

    @letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split('')

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = RestClient.get(url)
    result = JSON.parse(response.body)

    @is_word_valid = result['found']

    word_letters = @word.chars

    @is_letters_valid = word_letters.all? do |letter|
      word_letters.count(letter) <= @letters.count(letter)
    end

    @is_valid = @is_word_valid && @is_letters_valid

    @result_message = @is_valid ? "Congratulations! Your word is valid." : "Sorry, that's not a valid word."
  end
end
