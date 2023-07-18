# frozen_string_literal: true

class UserMovieRatingSerializer
  include JSONAPI::Serializer
  attributes :id, :rating

  belongs_to :movie
  belongs_to :user
end
