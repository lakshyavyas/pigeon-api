# frozen_string_literal: true

# == Schema Information
#
# Table name: core.guests
#
#  id         :integer          not null, primary key
#  meta_data  :jsonb            default("{}"), not null
#  identity   :jsonb            default("{}"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Core::Guest, type: :model do
  it { is_expected.to have_many(:inbound_messages) }
  it { is_expected.to have_many(:outbound_messages) }
end
