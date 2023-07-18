# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateUserMovieRating::EntryPoint do
  subject { described_class.new(params: params, user_movie_rating: user_movie_rating).call }

  let(:user_movie_rating) { create(:user_movie_rating, user: user, movie: movie) }
  let(:movie) { create(:movie) }
  let(:user) { create(:user) }

  before { user_movie_rating }

  describe 'when attributes are valid' do
    let(:params) {
      {
        movie_id: movie.id,
        user_id: user.id,
        rating: 5
      }
    }

    it 'update the movie showtime' do
      old_user_movie_rating = user_movie_rating
      expect { subject }.to change(user_movie_rating, :rating)
        .from(old_user_movie_rating.rating).to(params[:rating])
    end
  end

  describe 'when attributes are invalid' do
    let(:params) {
      {
        movie_id: movie.id,
        user_id: user.id,
        rating: 0
      }
    }

    it_behaves_like 'raises a ValidationError when field is nil'
  end
end
