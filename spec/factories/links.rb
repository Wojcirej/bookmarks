# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    name { Faker::GreekPhilosophers.unique.name }
    url { Faker::Internet.unique.url }
    description { Faker::GreekPhilosophers.unique.quote }
    association category, factory: :category, strategy: :create
  end
end
