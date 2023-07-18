# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Forgery::Email.address }
    password { Forgery::Basic.encrypt(random: true) }

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    trait :customer do
      after(:create) { |user| user.add_role(:customer) }
    end
  end
end
