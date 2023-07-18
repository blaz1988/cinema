# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Core::Forms::MovieShowtime do
  subject { described_class.new.call(params) }

  before { freeze_time }

  let(:movie) { create(:movie) }
  let(:movie_id) { movie.id }
  let(:showtime) { DateTime.now }

  let(:params) do
    {
      movie_id: movie_id,
      showtime: showtime,
      ticket_price_pennies: 1000
    }
  end

  describe 'when params are valid' do
    it 'returns the form' do
      expect(subject.to_h).to eq(params)
    end
  end

  describe 'when params are not valid' do
    it_behaves_like 'raises a ValidationError when field is nil' do
      let(:movie_id) { nil }
    end
    it_behaves_like 'raises a ValidationError when field is nil' do
      let(:showtime) { nil }
    end
    it_behaves_like 'raises a ValidationError when field is nil' do
      let(:showtime) { DateTime.now - 5.days }
    end
  end
end
