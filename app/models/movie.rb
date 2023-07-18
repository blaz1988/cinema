# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :movie_showtimes
  has_many :user_movie_ratings

  NOT_RATED = 'No user ratings'

  def rating
    return NOT_RATED if user_movie_ratings.empty?

    (user_movie_ratings.sum(&:rating).to_f / user_movie_ratings.count).round(2).to_s
  end
end
