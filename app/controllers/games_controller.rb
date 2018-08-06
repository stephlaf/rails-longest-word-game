require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new 
    @letters = (1..10).map { ("A".."Z").to_a[rand(26)] }
  end

  def score
    @end = Time.now
    @results = results
  end
end

private

def validate_at_api
  api = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
  JSON.parse(Kernel.open(api).read)
end

def validate_to_grid
  grid_hash = {}
  grid = params[:letters].delete" "
  grid.chars.each { |char| grid_hash[char] = grid.chars.count(char) }

  word_hash = {}
  word_array = params[:word].upcase.chars
  word_array.each { |char| word_hash[char] = word_array.count(char) }

  word_hash.each do |char, reps|
    grid_hash_reps = grid_hash[char]
    return false unless grid_hash_reps && reps <= grid_hash_reps
  end
  return true
end

def calc_score
  @start = params[:start]
  time = 1
  # @end - @start
  # raise
  (params[:word].size.to_f * 10) - (time)
end

def results
  if validate_at_api["found"] && validate_to_grid
    return "Good job! Your score is #{calc_score} points."
  elsif validate_at_api["found"] && validate_to_grid == false
    return "Your word does not match the letters we gave you..."
  else
    return "Your word is not an English word."

  end
end


























