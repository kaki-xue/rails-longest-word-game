class GamesController < ApplicationController
  def new
    @letters = Array.new(15) { ('A'..'Z').to_a.sample }
  end

  def score
    @userinput = params[:userword].upcase
    @letter_arr = params[:letters]
    include_arr = @userinput.chars.map do |letter|
      @letter_arr.include?(letter)
    end
    @result = include_arr.include?(false) ? "Sorry #{@userinput} cant be built out of #{@letter_arr}" : english_word()
  end

  def english_word
    response = open("https://wagon-dictionary.herokuapp.com/#{@userinput}")
    json = JSON.parse(response.read)
    @result = json['found'] ? "congratulations!" : "Sorry #{@userinput} is not an english word"
  end
end
