# frozen_string_literal: true

module CreateMovieShowtime
  class Action
    def initialize(form:)
      @form = form
    end

    def call
      movie_showtime = MovieShowtime.new(form.to_h)
      movie_showtime.save
      movie_showtime
    end

    private

    attr_reader :form
  end
end
