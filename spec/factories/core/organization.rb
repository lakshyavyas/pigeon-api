# frozen_string_literal: true

FactoryBot.define do
  factory :organization, class: 'Core::Organization' do
    name { Faker::Company.name }
  end
end
