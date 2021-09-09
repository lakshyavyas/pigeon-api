# frozen_string_literal: true

# == Schema Information
#
# Table name: simple_auths
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_simple_auths_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe SimpleAuth, type: :model do
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to belong_to(:user) }
end
