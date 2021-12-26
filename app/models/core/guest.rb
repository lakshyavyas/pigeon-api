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

module Core
  class Guest < ApplicationRecord
    has_many :inbound_messages, as: :recipient, class_name: 'Core::Message'
    has_many :outbound_messages, as: :sender, class_name: 'Core::Message'
    serialize :meta_data, HashSerializer
    serialize :identity, HashSerializer
  end
end
