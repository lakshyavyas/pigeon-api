# frozen_string_literal: true

# == Schema Information
#
# Table name: core.accesses
#
#  id           :bigint           not null, primary key
#  access_token :string
#  active       :boolean          default(TRUE)
#  expires_at   :datetime
#  renew_token  :string
#  token_type   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  core.user_id :bigint           not null
#
# Indexes
#
#  index_core.accesses_on_core.user_id  (core.user_id)
#
# Foreign Keys
#
#  fk_rails_...  (core.user_id => users.id)
#

FactoryBot.define do
  factory :access_expired, class: 'Core::Access' do
    access_token { "at-#{SecureRandom.hex(20)}" }
    renew_token { "at-#{SecureRandom.hex(20)}" }
    token_type { :api }
    expires_at { Time.now - 1.hour }
    user { FactoryBot.create(:simple_auth_users) }
  end

  factory :access_inactive, class: 'Core::Access' do
    access_token { "at-#{SecureRandom.hex(20)}" }
    renew_token { "at-#{SecureRandom.hex(20)}" }
    token_type { :api }
    expires_at { Time.now + 1.hour }
    active { false }
    user { FactoryBot.create(:simple_auth_users) }
  end
end
