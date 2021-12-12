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
class Message < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :sender, polymorphic: true
  validates :data, presence: true
end
