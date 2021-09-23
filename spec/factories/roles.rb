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
  factory :user_role, class: 'Role' do
    title { 'User' }
    description { 'Default user role' }
    scope { roles_config[:default_user] }
  end

  factory :admin_role, class: 'Role' do
    title { 'Admin' }
    description { 'Default admin role' }
    scope { roles_config[:default_admin] }
  end
end
