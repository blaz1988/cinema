# frozen_string_literal: true

module CreateMovieShowtime
  class EntryPoint
    def initialize(params:)
      @params = params

      @form = Core::Forms::MovieShowtime.new.call(params)
      @action = Action.new(form: form)
    end

    def call
      @action.call
    end

    private

    attr_reader :params, :form
  end
end
