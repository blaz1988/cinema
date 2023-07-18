# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    rescue_from Exceptions::ValidationError, with: :render_validation_errors

    private

    def render_validation_errors exception
      render json: { errors: exception.message }, status: :unprocessable_entity
    end
  end
end
