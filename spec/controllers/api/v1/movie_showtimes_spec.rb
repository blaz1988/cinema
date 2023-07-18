# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe Api::V1::MovieShowtimesController, type: :request do
  let(:user) { create(:user, :admin) }
  let(:movie_showtimes) { create_list(:movie_showtime, 2) }
  let(:movie_showtime) { movie_showtimes.first }
  let(:movie) { movie_showtime.movie }
  let(:movie_showtimes_json) {
    MovieShowtimeSerializer.new(movie_showtimes).serializable_hash.to_json
  }
  let(:valid_attributes) {
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
  let(:invalid_attributes) {
    {
      data: {
        attributes: {
          movie_id: movie.id,
          showtime: DateTime.now - 4.days,
          ticket_price_pennies: 16_000
        }
      }
    }
  }

  before do
    freeze_time

    movie_showtimes_json
    movie_showtimes_json
  end

  describe 'when user is logged in' do
    before { sign_in(user) }

    context 'GET /index' do
      it 'renders a successful response' do
        get api_v1_movie_showtimes_url, as: :json
        expect(response).to be_successful
      end
    end

    context 'GET /show' do
      it 'renders a successful response' do
        get api_v1_movie_showtime_url(movie_showtime), as: :json
        expect(response).to be_successful
      end
    end
  end

  describe 'when user is not logged in' do
    context 'GET /index' do
      it 'renders a successful response' do
        get api_v1_movie_showtimes_url, as: :json
        expect(response).not_to be_successful
      end
    end

    context 'GET /show' do
      it 'renders a successful response' do
        get api_v1_movie_showtime_url(movie_showtime), as: :json
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST /create' do
    before { sign_in(user) }

    context 'with valid parameters' do
      it 'creates a new MovieShowtime' do
        expect {
          post api_v1_movie_showtimes_url,
               params: valid_attributes, as: :json
        }.to change(MovieShowtime, :count).by(1)
      end

      it 'renders a JSON response with the new api/v1/movie_showtime' do
        post api_v1_movie_showtimes_url,
             params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new MovieShowtime' do
        expect {
          post api_v1_movie_showtimes_url,
               params: invalid_attributes, as: :json
        }.to change(MovieShowtime, :count).by(0)
      end

      it 'renders a JSON response with errors for the new api/v1/movie_showtime' do
        post api_v1_movie_showtimes_url,
             params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with a user that does not have the right role' do
      before { sign_in(create(:user, :customer)) }

      it 'does not create a new MovieShowtime' do
        expect {
          post api_v1_movie_showtimes_url,
               params: invalid_attributes, as: :json
        }.to change(MovieShowtime, :count).by(0)
      end

      it 'renders a JSON response with errors for the new api/v1/movie_showtime' do
        post api_v1_movie_showtimes_url,
             params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with the non existing movie_id' do
      let(:invalid_attributes) {
        {
          data: {
            attributes: {
              movie_id: -1,
              showtime: DateTime.now + 4.days,
              ticket_price_pennies: 16_000
            }
          }
        }
      }

      it 'does not create a new MovieShowtime' do
        expect {
          post api_v1_movie_showtimes_url,
               params: invalid_attributes, as: :json
        }.to change(MovieShowtime, :count).by(0)
      end

      it 'renders a JSON response with errors for the new api/v1/movie_showtime' do
        post api_v1_movie_showtimes_url,
             params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    before { sign_in(user) }

    context 'with valid parameters' do
      let(:new_attributes) {
        {
          data: {
            attributes: {
              movie_id: movie.id,
              showtime: Time.zone.now + 15.days,
              ticket_price_pennies: 3000
            }
          }
        }
      }

      it 'updates the requested api/v1/movie_showtime' do
        patch api_v1_movie_showtime_url(movie_showtime),
              params: new_attributes, as: :json
        movie_showtime.reload
        expect(movie_showtime.showtime).to eq(new_attributes[:data][:attributes][:showtime])
        expect(movie_showtime.ticket_price_pennies).to eq(new_attributes[:data][:attributes][:ticket_price_pennies])
      end

      it 'renders a JSON response with the api/v1/movie_showtime' do
        patch api_v1_movie_showtime_url(movie_showtime),
              params: new_attributes, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the api/v1/movie_showtime' do
        patch api_v1_movie_showtime_url(movie_showtime),
              params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end