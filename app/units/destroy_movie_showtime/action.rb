# frozen_string_literal: true

module DestroyMovieShowtime
  class Action
    def initialize(movie_showtime:)
      @movie_showtime = movie_showtime
    end

    def call
      movie_showtime.destroy
    end

    private

    attr_reader :movie_showtime
  end
end
