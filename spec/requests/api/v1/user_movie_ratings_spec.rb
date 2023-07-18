# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/user_movie_ratings', type: :request do
  include_examples 'authorization variables'

  let(:user_movie_rating) { create(:user_movie_rating, movie: movie, user: user) }
  let(:user) { create(:user, :customer) }
  let(:movie) { create(:movie) }
  let(:Authorization) { {} }

  before do
    sign_in(user)
  end

  path '/api/v1/user_movie_ratings' do
    post('create user_movie_rating') do
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: { '$ref' => '#/components/user_movie_rating' }
      security SECURITIES

      response(201, 'created') do
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                rating: 1
              }
            }
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

      response(422, 'validation error') do
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                rating: 0
              }
            }
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

  path '/api/v1/user_movie_ratings/{id}' do
    patch('update user_movie_rating') do
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: { '$ref' => '#/components/user_movie_rating' }
      parameter name: :id, in: :path, type: :string, description: 'id'
      security SECURITIES

      response(200, 'successful') do
        let(:id) { user_movie_rating.id }
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                rating: 1
              }
            }
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

      response(422, 'validation error') do
        let(:id) { user_movie_rating.id }
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                rating: 0
              }
            }
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
