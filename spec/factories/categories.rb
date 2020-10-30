# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::FunnyName.unique.name }
    ancestry { nil }
  end
end
