# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  description :string
#  scope       :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { described_class.new }

  it { is_expected.to validate_presence_of(:scope) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:scope).is_at_least(2).is_at_most(20) }
  it { is_expected.to validate_length_of(:title).is_at_least(2).is_at_most(20) }
  it { is_expected.to validate_length_of(:description).is_at_least(10).is_at_most(200) }
end
