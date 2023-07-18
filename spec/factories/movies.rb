# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    name { Forgery::Name.full_name }
    release_date { DateTime.now }
    description { Forgery::Basic.text }
    imdb_rating { 1.5 }
  end
end
