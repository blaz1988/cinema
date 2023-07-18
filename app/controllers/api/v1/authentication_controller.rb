# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < Api::ApiController
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_api_v1_user!

      def authenticate_admin_user!
        (respond_with_admin_auth_error and return) unless current_api_v1_user.admin?
      end

      private

      def respond_with_admin_auth_error
        render json: { errors: auth_errors }, status: :unauthorized
      end

      def auth_errors
        @auth_error_message ||= I18n.t('errors.must_be_logged_in_to_continue')
        { message: @auth_error_message }
      end
    end
  end
end
