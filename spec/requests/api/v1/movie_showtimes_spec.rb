# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/movie_showtimes', type: :request do
  include_examples 'authorization variables'

  let(:movie_showtime) { create(:movie_showtime) }
  let(:movie) { create(:movie) }

  before do
    sign_in(create(:user, :admin))
  end

  path '/api/v1/movie_showtimes' do
    get('list movie_showtimes') do
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

    post('create movie_showtime') do
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: { '$ref' => '#/components/movie_showtime' }
      security SECURITIES

      response(201, 'created') do
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                showtime: DateTime.now + 3.days,
                ticket_price_pennies: 16_000
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
                showtime: DateTime.now - 3.days,
                ticket_price_pennies: 16_000
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

  path '/api/v1/movie_showtimes/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show movie_showtime') do
      security SECURITIES

      response(200, 'successful') do
        let(:id) { movie_showtime.id }

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

    patch('update movie_showtime') do
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: { '$ref' => '#/components/movie_showtime' }
      security SECURITIES

      response(200, 'successful') do
        let(:id) { movie_showtime.id }
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                showtime: DateTime.now + 10.days,
                ticket_price_pennies: 25_000
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
        let(:id) { movie_showtime.id }
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                showtime: DateTime.now - 10.days,
                ticket_price_pennies: 25_000
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

    put('update movie_showtime') do
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: { '$ref' => '#/components/movie_showtime' }
      security SECURITIES

      response(200, 'successful') do
        let(:id) { movie_showtime.id }
        let(:params) {
          {
            data: {
              attributes: {
                movie_id: movie.id,
                showtime: DateTime.now + 10.days,
                ticket_price_pennies: 25_000
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

    delete('delete movie_showtime') do
      security SECURITIES

      response(204, 'deleted') do
        let(:id) { movie_showtime.id }

        run_test!
      end
    end
  end
end
