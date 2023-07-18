# frozen_string_literal: true

module CreateUserMovieRating
  class Action
    def initialize(form:)
      @form = form
    end

    def call
      user_movie_rating = UserMovieRating.new(form.to_h)
      user_movie_rating.save
      user_movie_rating
    end

    private

    attr_reader :form
  end
end
