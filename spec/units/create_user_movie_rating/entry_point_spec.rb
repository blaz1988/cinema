# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateUserMovieRating::EntryPoint do
  subject { described_class.new(params: params).call }

  let(:movie) { create(:movie) }
  let(:user) { create(:user) }

  before { freeze_time }

  describe 'when attributes are valid' do
    let(:params) {
      {
        movie_id: movie.id,
        user_id: user.id,
        rating: 3
      }
    }

    it 'creates a new movie showtime' do
      expect { subject }.to change(UserMovieRating, :count).from(0).to(1)
    end
  end

  describe 'when attributes are invalid' do
    let(:params) {
      {
        movie_id: movie.id,
        user_id: user.id,
        ratings: 0
      }
    }

    it_behaves_like 'raises a ValidationError when field is nil'
  end
end
