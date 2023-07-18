# frozen_string_literal: true

module Exceptions
  class ValidationError < StandardError
    def initialize(params:)
      @params = params

      super
    end

    def message
      @params.errors.messages.map { |error| { message: error.text, field: error.path.first } }
    end
  end
end
