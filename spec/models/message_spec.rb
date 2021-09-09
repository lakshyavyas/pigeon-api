# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id             :bigint           not null, primary key
#  data           :jsonb
#  recipient_type :string           not null
#  sender_type    :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recipient_id   :bigint           not null
#  sender_id      :bigint           not null
#
# Indexes
#
#  index_messages_on_recipient  (recipient_type,recipient_id)
#  index_messages_on_sender     (sender_type,sender_id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to validate_presence_of(:data) }
  it { is_expected.to belong_to(:recipient) }
  it { is_expected.to belong_to(:sender) }
end
