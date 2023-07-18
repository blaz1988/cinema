# frozen_string_literal: true

module DestroyMovieShowtime
  class EntryPoint
    def initialize(movie_showtime:)
      @action = Action.new(movie_showtime: movie_showtime)
    end

    def call
      action.call
    end

    private

    attr_reader :action
  end
end
