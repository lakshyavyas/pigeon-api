# frozen_string_literal: true

# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  identity   :jsonb
#  meta_data  :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Guest, type: :model do
  it { is_expected.to have_many(:inbound_messages) }
  it { is_expected.to have_many(:outbound_messages) }
end
