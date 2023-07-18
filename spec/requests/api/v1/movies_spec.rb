# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  include_examples 'authorization variables'

  let(:movie) { create(:movie) }
  let(:Authorization) { {} }

  before do
    sign_in(create(:user, :admin))
  end

  path '/api/v1/movies' do
    get('list movies') do
      security SECURITIES

      response(200, 'successful') do
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

  path '/api/v1/movies/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show movie') do
      security SECURITIES

      response(200, 'successful') do
        let(:id) { movie.id }

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
