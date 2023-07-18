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

RSpec.describe Api::V1::UserMovieRatingsController, type: :request do
  let(:user) { create(:user, :customer) }
  let(:movie) { create(:movie) }
  let(:new_movie) { create(:movie) }
  let(:user_movie_rating) { create(:user_movie_rating, movie: movie, user: user) }
  let(:valid_attributes) {
    {
      data: {
        attributes: {
          movie_id: new_movie.id,
          rating: 3
        }
      }
    }
  }
  let(:invalid_attributes) {
    {
      data: {
        attributes: {
          movie_id: new_movie.id,
          rating: 0
        }
      }
    }
  }

  before do
    sign_in(user)

    movie
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new UserMovieRating' do
        expect {
          post api_v1_user_movie_ratings_url,
               params: valid_attributes, as: :json
        }.to change(UserMovieRating, :count).by(1)
      end

      it 'renders a JSON response with the new api/v1/user_movie_rating' do
        post api_v1_user_movie_ratings_url,
             params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new UserMovieRating' do
        expect {
          post api_v1_user_movie_ratings_url,
               params: invalid_attributes, as: :json
        }.to change(UserMovieRating, :count).by(0)
      end

      it 'renders a JSON response with errors for the new api/v1/user_movie_rating' do
        post api_v1_user_movie_ratings_url,
             params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      context 'when wrong movie_id is sent' do
        let(:invalid_attributes) {
          {
            data: {
              attributes: {
                movie_id: -1,
                rating: 0
              }
            }
          }
        }

        it 'renders a JSON response with errors for the api/v1/user_movie_rating' do
          expect {
            post api_v1_user_movie_ratings_url,
                 params: invalid_attributes, as: :json
          }.to change(UserMovieRating, :count).by(0)
        end
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        {
          data: {
            attributes: {
              movie_id: movie.id,
              rating: 3
            }
          }
        }
      }

      it 'updates the requested api/v1/user_movie_rating' do
        patch api_v1_user_movie_rating_url(user_movie_rating),
              params: new_attributes, as: :json
        user_movie_rating.reload
        expect(user_movie_rating.rating).to eq(new_attributes[:data][:attributes][:rating])
      end

      it 'renders a JSON response with the api/v1/user_movie_rating' do
        patch api_v1_user_movie_rating_url(user_movie_rating),
              params: new_attributes, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the api/v1/user_movie_rating' do
        patch api_v1_user_movie_rating_url(user_movie_rating),
              params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      context 'when wrong movie_id is sent' do
        let(:invalid_attributes) {
          {
            data: {
              attributes: {
                movie_id: -1,
                rating: 0
              }
            }
          }
        }

        it 'renders a JSON response with errors for the api/v1/user_movie_rating' do
          patch api_v1_user_movie_rating_url(user_movie_rating),
                params: invalid_attributes, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end