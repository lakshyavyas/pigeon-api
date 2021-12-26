# frozen_string_literal: true

FactoryBot.define do
  factory :channel, class: 'Core::Channel' do
    name { Faker::Lorem.characters(number: 10) }
  end
end
