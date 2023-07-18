# frozen_string_literal: true

module UpdateUserMovieRating
  class Action
    def initialize(form:, user_movie_rating:)
      @form = form
      @user_movie_rating = user_movie_rating
    end

    def call
      user_movie_rating.update(form.to_h)
      user_movie_rating
    end

    private

    attr_reader :form, :user_movie_rating
  end
end
