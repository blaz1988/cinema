# frozen_string_literal: true

class MovieShowtimeSerializer
  include JSONAPI::Serializer
  include ActiveSupport::NumberHelper
  attributes :id, :showtime

  attribute :ticket_price do |movie_showtime, _params|
    ticket_price = movie_showtime.ticket_price_pennies / 100

    ActionController::Base.helpers.number_to_currency(ticket_price)
  end

  attribute :name do |movie_showtime, _params|
    movie_showtime.movie.name
  end

  belongs_to :movie
end
