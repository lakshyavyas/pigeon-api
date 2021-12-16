# frozen_string_literal: true

# == Schema Information
#
# Table name: core.groups
#
#  id         :integer          not null, primary key
#  name       :string
#  group_type :integer
#  meta_data  :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Core
  class Group < ApplicationRecord
    enum group_type: %i[channel team conversation]

    validates :name, presence: true, length: { minimum: 2, maximum: 20 }
    validates :group_type, presence: true

    has_many :user_groups
    has_many :users, through: :user_groups

    has_many :inbound_messages, as: :recipient, class_name: 'Core::Message'
    has_many :outbound_messages, as: :sender, class_name: 'Core::Message'
  end
end
