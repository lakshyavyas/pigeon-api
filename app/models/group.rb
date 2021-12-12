# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  group_type :integer
#  meta_data  :jsonb
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Group < ApplicationRecord
  enum group_type: %i[channel team conversation]

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :group_type, presence: true

  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :inbound_messages, as: :recipient, class_name: 'Message'
  has_many :outbound_messages, as: :sender, class_name: 'Message'
end
