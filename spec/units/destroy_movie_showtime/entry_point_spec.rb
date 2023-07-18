# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovieShowtime::EntryPoint do
  subject { described_class.new(movie_showtime: movie_showtime).call }

  let(:movie_showtime) { create(:movie_showtime) }

  before do
    freeze_time

    movie_showtime
  end

  it 'destroys a movie showtime' do
    expect { subject }.to change(MovieShowtime, :count).from(1).to(0)
  end
end
