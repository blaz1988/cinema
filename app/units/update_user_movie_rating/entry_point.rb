# frozen_string_literal: true

module UpdateUserMovieRating
  class EntryPoint
    def initialize(params:, user_movie_rating:)
      form = Form.new.call(params)
      @action = Action.new(form: form, user_movie_rating: user_movie_rating)
    end

    def call
      action.call
    end

    private

    attr_reader :action
  end
end
