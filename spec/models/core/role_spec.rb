# frozen_string_literal: true

# == Schema Information
#
# Table name: core.roles
#
#  id            :integer          not null, primary key
#  resource_type :string           not null
#  resource_id   :integer          not null
#  roleable_type :string           not null
#  roleable_id   :integer          not null
#  logical_name  :string(255)
#  role_arn      :string(255)
#  role_level    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_core.roles_on_resource  (resource_type,resource_id)
#  index_core.roles_on_roleable  (roleable_type,roleable_id)
#

require 'rails_helper'

RSpec.describe Core::Role, type: :model do
  subject { described_class.new }

  it { is_expected.to belong_to(:resource) }
  it { is_expected.to belong_to(:roleable) }
  it { is_expected.to validate_presence_of(:logical_name) }
  it { is_expected.to validate_presence_of(:role_level) }
end
