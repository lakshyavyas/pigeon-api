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
class Guest < ApplicationRecord
  has_many :inbound_messages, as: :recipient, class_name: 'Message'
  has_many :outbound_messages, as: :sender, class_name: 'Message'
end
