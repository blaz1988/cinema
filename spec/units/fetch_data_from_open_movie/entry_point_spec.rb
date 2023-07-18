# frozen_string_literal: true

require 'rails_helper'

URL = 'http://www.omdbapi.com/'

RSpec.describe FetchDataFromOpenMovie::EntryPoint do
  subject { described_class.new(imdb_id: imdb_id).call }

  let(:imdb_id) { 'tt0232500' }

  before { imdb_id }

  it 'queries OpenMovieDatabase' do
    expect(subject['Title']).to eq('The Fast and the Furious')
  end
end
