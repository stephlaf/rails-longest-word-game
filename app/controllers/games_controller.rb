require 'open-uri'
require 'json'
require 'pry-byebug'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map { ("A".."Z").to_a[rand(26)] }
  end

  def score
    @results = results
    # raise

  end
end

private

def validate_at_api
  api = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
  JSON.parse(Kernel.open(api).read)
    # binding.pry
  
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
  # binding.pry
  end
  return true

end

def calc_time
  time = params[:start] - params[:end]
end

def calc_score
  (params[:word].size.to_f * 10) - (time)
end


def results


  if validate_at_api["found"] && validate_to_grid
    return "Valid word"
  else
    return "Invalid word"

  end
end


























