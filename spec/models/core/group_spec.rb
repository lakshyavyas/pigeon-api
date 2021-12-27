# frozen_string_literal: true

# == Schema Information
#
# Table name: core.groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :string(255)      default("Core::Team")
#  meta_data  :jsonb            default("{}"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.groups_on_meta_data  (meta_data)
#  index_core.groups_on_type       (type)
#

require 'rails_helper'

RSpec.describe Core::Group, type: :model do
  attr_accessor :team, :other_user

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(255) }
  it { is_expected.to have_many(:roles) }
  it { is_expected.to have_many(:inbound_messages) }
  it { is_expected.to have_many(:outbound_messages) }
  it { is_expected.to respond_to(:owners) }
end
