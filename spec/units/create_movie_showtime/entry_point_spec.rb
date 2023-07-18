# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovieShowtime::EntryPoint do
  subject { described_class.new(params: params).call }

  let(:movie) { create(:movie) }

  before { freeze_time }

  describe 'when attributes are valid' do
    let(:params) {
      {
        movie_id: movie.id,
        showtime: DateTime.now + 3.days,
        ticket_price_pennies: 16_000
      }
    }

    it 'creates a new movie showtime' do
      expect { subject }.to change(MovieShowtime, :count).from(0).to(1)
    end
  end

  describe 'when attributes are invalid' do
    let(:params) {
      {
        movie_id: movie.id,
        showtime: DateTime.now - 3.days,
        ticket_price_pennies: 16_000
      }
    }

    it_behaves_like 'raises a ValidationError when field is nil'
  end
end
