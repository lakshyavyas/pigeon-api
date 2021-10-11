# frozen_string_literal: true

# == Schema Information
#
# Table name: core.groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :string(255)      default("Core::Team")
#  meta_data  :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.groups_on_type  (type)
#

module Core
  class Group < ApplicationRecord
    validates :name, presence: true, length: { minimum: 2, maximum: 255 }
    validates :type, presence: true
    has_many :roles, as: :roleable, class_name: 'Core::UserRole'

    has_many :inbound_messages, as: :recipient, class_name: 'Core::Message'
    has_many :outbound_messages, as: :sender, class_name: 'Core::Message'

    def users
      roles.map(&:user)
    end

    def admins
      roles.admin.map(&:user)
    end

    def owners
      roles.owner.map(&:user)
    end

    def members
      roles.member.map(&:user)
    end
  end
end
