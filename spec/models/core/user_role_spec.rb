# frozen_string_literal: true
# == Schema Information
#
# Table name: core.user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  role_arn   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.user_roles_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Core::UserRole, type: :model do
  subject { described_class.new }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:role_arn) }
end
