require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    random = Array('A'..'Z')
    @letters = []
    10.times { @letters << random.sample }
    @letters
  end

  def score
    if !word_used_letters_from_grid?(params[:word], params[:letters])
      @scenario = 1
      @score = 0
    elsif !word_exists?(params[:word])
      @scenario = 2
      @score = 0
    else
      @score = 1 + params[:word].length
    end
  end

  def word_used_letters_from_grid?(word, grid)
    word.upcase.split('').all? { |letter| grid.upcase.count(letter) >= word.upcase.count(letter) }
  end

  def word_exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found'] ? true : false
  end
end
