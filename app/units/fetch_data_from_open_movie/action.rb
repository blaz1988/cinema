# frozen_string_literal: true

require 'net/http'

module FetchDataFromOpenMovie
  class Action
    URL = 'http://www.omdbapi.com/'

    def initialize(imdb_id:)
      @imdb_id = imdb_id
    end

    def call
      fetch_movie_data
    end

    private

    attr_reader :imdb_id

    def fetch_movie_data
      uri = URI(URL)
      uri.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri.host, uri.port)
      res = http.get(uri.request_uri)
      ActiveSupport::JSON.decode(res.body)
    end

    def params
      { apikey: ENV['OPEN_MOVIE_API_ID'], i: imdb_id, format: 'json' }
    end
  end
end
