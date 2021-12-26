# frozen_string_literal: true

FactoryBot.define do
  factory :team, class: 'Core::Team' do
    name { Faker::Lorem.characters(number: 10) }
  end
end
