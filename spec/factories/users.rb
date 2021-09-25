# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :simple_auth_admins, class: 'User' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    simple_auth { SimpleAuth.create(password: '123123') }
    user_roles do
      [UserRole.create(role_arn: roles_config[:default_user]),
       UserRole.create(role_arn: roles_config[:default_admin])]
    end
  end

  factory :simple_auth_users, class: 'User' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    simple_auth { SimpleAuth.create(password: '123123') }
    user_roles { [UserRole.create(role_arn: roles_config[:default_user])] }
  end
end
