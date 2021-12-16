# frozen_string_literal: true

# == Schema Information
#
# Table name: core.users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Core::User, type: :model do
  subject { described_class.new }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(20) }
  it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(20) }
  it { is_expected.to validate_length_of(:email).is_at_least(2).is_at_most(100) }
  it { is_expected.to have_many(:user_roles) }
  it { is_expected.to have_one(:simple_auth) }
  it { is_expected.to have_many(:user_groups) }
  it { is_expected.to have_many(:groups) }
  it { is_expected.to have_many(:inbound_messages) }
  it { is_expected.to have_many(:outbound_messages) }
  it { is_expected.to have_many(:accesses) }

  allowed_types = %w[image/png image/jpeg]
  rejected_types = %w[text/plain text/xml]
  it { is_expected.to validate_content_type_of(:avatar).allowing(allowed_types).rejecting(rejected_types) }
  it { is_expected.to validate_size_of(:avatar).less_than(512.kilobytes) }
end
