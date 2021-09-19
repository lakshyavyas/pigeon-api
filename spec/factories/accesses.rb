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
  factory :access_expired, class: 'Access' do
    access_token { "at-#{SecureRandom.hex(20)}" }
    renew_token { "at-#{SecureRandom.hex(20)}" }
    token_type { :api }
    expires_at { Time.now - 1.hour }
    user { FactoryBot.create(:simple_auth_users) }
  end

  factory :access_inactive, class: 'Access' do
    access_token { "at-#{SecureRandom.hex(20)}" }
    renew_token { "at-#{SecureRandom.hex(20)}" }
    token_type { :api }
    expires_at { Time.now + 1.hour }
    active { false }
    user { FactoryBot.create(:simple_auth_users) }
  end
end
