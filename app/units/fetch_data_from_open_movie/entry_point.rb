# frozen_string_literal: true

module FetchDataFromOpenMovie
  class EntryPoint
    def initialize(imdb_id:)
      @action = Action.new(imdb_id: imdb_id)
    end

    def call
      action.call
    end

    private

    attr_reader :action
  end
end
