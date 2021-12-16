# frozen_string_literal: true

# == Schema Information
#
# Table name: core.messages
#
#  id             :integer          not null, primary key
#  recipient_type :string           not null
#  recipient_id   :integer          not null
#  sender_type    :string           not null
#  sender_id      :integer          not null
#  data           :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_core.messages_on_recipient  (recipient_type,recipient_id)
#  index_core.messages_on_sender     (sender_type,sender_id)
#

require 'rails_helper'

RSpec.describe Core::Message, type: :model do
  it { is_expected.to validate_presence_of(:data) }
  it { is_expected.to belong_to(:recipient) }
  it { is_expected.to belong_to(:sender) }
end
