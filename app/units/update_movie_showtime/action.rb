# frozen_string_literal: true

module UpdateMovieShowtime
  class Action
    def initialize(form:, movie_showtime:)
      @form = form
      @movie_showtime = movie_showtime
    end

    def call
      movie_showtime.update(form.to_h)
      movie_showtime
    end

    private

    attr_reader :form, :movie_showtime
  end
end
