# frozen_string_literal: true

class UserMovieRating < ApplicationRecord
  belongs_to :user
  belongs_to :movie
end
