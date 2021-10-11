# frozen_string_literal: true

# == Schema Information
#
# Table name: core.organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Core::Organization, type: :model do
  subject { described_class.new }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(255) }
  it { is_expected.to have_many(:roles) }

  allowed_types = %w[image/png image/jpeg]
  rejected_types = %w[text/plain text/xml]
  it { is_expected.to validate_content_type_of(:logo).allowing(allowed_types).rejecting(rejected_types) }
  it { is_expected.to validate_size_of(:logo).less_than(512.kilobytes) }
end
