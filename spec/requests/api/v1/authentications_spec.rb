# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/authentications', type: :request do
  let(:user) { create(:user) }

  path '/api/v1/authentications/sign_in' do
    post('create user session') do
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: { '$ref' => '#/components/user' }

      response(200, 'created') do
        header 'access-token', type: :string, description: 'Authorizations token'
        header 'token-type', type: :string, description: 'Token type'
        header 'client', type: :string, description: 'Client token'
        header 'expiry', type: :string, description: 'Token expiration time'
        header 'ETag', type: :string, description: 'Web cache validation'

        let(:params) {
          {
            email: user.email,
            password: user.password
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response(401, 'nvalid login credentials') do
        let(:params) {
          {
            email: 'non@existing.com',
            password: 'secret'
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
