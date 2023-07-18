# frozen_string_literal: true

module Requests
  module AuthHelpers
    HTTP_HELPERS_TO_OVERRIDE =
      %i[get post patch put delete].freeze

    def sign_in(user)
      @auth_helpers_auth_token = user.create_new_auth_token
    end

    HTTP_HELPERS_TO_OVERRIDE.each do |helper|
      define_method(helper) do |path, **args|
        add_auth_headers(args)
        args == {} ? super(path) : super(path, **args)
      end
    end

    private

    attr_accessor :auth_helpers_auth_token

    def add_auth_headers(args)
      return unless auth_helpers_auth_token.present?

      args[:headers] ||= {}
      args[:headers].merge!(auth_helpers_auth_token)
    end
  end
end
