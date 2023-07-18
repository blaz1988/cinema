# frozen_string_literal: true

FactoryBot.define do
  factory :user_movie_rating do
    rating { 1 }

    association :user, factory: :user
    association :movie, factory: :movie
  end
end
