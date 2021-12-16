# frozen_string_literal: true

# == Schema Information
#
# Table name: core.accesses
#
#  id           :integer          not null, primary key
#  access_token :string
#  renew_token  :string
#  token_type   :integer
#  expires_at   :datetime
#  active       :boolean          default("true")
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_core.accesses_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Core::Access, type: :model do
  it { is_expected.to validate_presence_of(:token_type) }
  it { is_expected.to belong_to(:user) }
end
