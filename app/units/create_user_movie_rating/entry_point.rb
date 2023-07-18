# frozen_string_literal: true

module CreateUserMovieRating
  class EntryPoint
    def initialize(params:)
      form = Core::Forms::UserMovieRating.new.call(params)
      @action = Action.new(form: form)
    end

    def call
      action.call
    end

    private

    attr_reader :action
  end
end
