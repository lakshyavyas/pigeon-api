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

module Core
  class Message < ApplicationRecord
    belongs_to :recipient, polymorphic: true
    belongs_to :sender, polymorphic: true
    validates :data, presence: true
  end
end
