# frozen_string_literal: true

class MovieSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :release_date, :runtime, :rating, :imdb_rating, :description
end
