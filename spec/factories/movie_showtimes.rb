# frozen_string_literal: true

FactoryBot.define do
  factory :movie_showtime do
    showtime { DateTime.now }
    ticket_price_pennies { 1000 }

    association :movie
  end
end
