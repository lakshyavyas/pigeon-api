# frozen_string_literal: true

# == Schema Information
#
# Table name: core.users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :simple_auth_admins, class: 'Core::User' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    simple_auth { Core::SimpleAuth.create(password: '123123') }
    roles do
      [Core::Role.create(resource: Core::Organization.first,
                         logical_name: 'organization',
                         role_level: Core::Role.role_levels[:admin]),
       Core::Role.create(resource: Core::Organization.first,
                         logical_name: 'organization',
                         role_level: Core::Role.role_levels[:member])]
    end
  end

  factory :simple_auth_users, class: 'Core::User' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    simple_auth { Core::SimpleAuth.create(password: '123123') }
    roles do
      [Core::Role.create(resource: Core::Organization.first,
                         logical_name: 'organization',
                         role_level: Core::Role.role_levels[:member])]
    end
  end
end
