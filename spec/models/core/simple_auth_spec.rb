# frozen_string_literal: true

# == Schema Information
#
# Table name: core.simple_auths
#
#  id              :integer          not null, primary key
#  password_digest :string
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_core.simple_auths_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Core::SimpleAuth, type: :model do
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to belong_to(:user) }
end
