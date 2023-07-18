# frozen_string_literal: true

module UpdateMovieShowtime
  class EntryPoint
    def initialize(params:, movie_showtime:)
      form = Core::Forms::MovieShowtime.new.call(params)
      @action = Action.new(form: form, movie_showtime: movie_showtime)
    end

    def call
      action.call
    end

    private

    attr_reader :action
  end
end
