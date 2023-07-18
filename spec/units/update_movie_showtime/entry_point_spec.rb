# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMovieShowtime::EntryPoint do
  subject { described_class.new(params: params, movie_showtime: movie_showtime).call }

  let(:movie_showtime) { create(:movie_showtime) }
  let(:movie) { create(:movie) }

  before do
    freeze_time

    movie_showtime
  end

  describe 'when attributes are valid' do
    let(:params) {
      {
        movie_id: movie.id,
        showtime: DateTime.now + 3.days,
        ticket_price_pennies: 16_000
      }
    }

    it 'update the movie showtime' do
      old_movie_showtime = movie_showtime
      expect { subject }.to change(movie_showtime, :movie_id)
        .from(old_movie_showtime.movie_id).to(params[:movie_id])
        .and change(movie_showtime,
                    :showtime)
        .from(old_movie_showtime.showtime)
        .to(params[:showtime])
        .and change(movie_showtime,
                    :ticket_price_pennies)
        .from(old_movie_showtime.ticket_price_pennies)
        .to(params[:ticket_price_pennies])
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
