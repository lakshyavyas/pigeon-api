# frozen_string_literal: true

# == Schema Information
#
# Table name: core.user_roles
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  roleable_type :string           not null
#  roleable_id   :integer          not null
#  logical_name  :string(255)
#  role_level    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_core.user_roles_on_roleable  (roleable_type,roleable_id)
#  index_core.user_roles_on_user_id   (user_id)
#

module Core
  class UserRole < ApplicationRecord
    enum role_level: %i[owner admin member]

    belongs_to :user
    belongs_to :roleable, polymorphic: true
    validates :logical_name, presence: true
    validates :role_level, presence: true

    def role_arn
      "#{role_level}::#{logical_name}::#{mask_value(roleable_id)}"
    end

    def owner?
      role_level == 'owner'
    end
  end
end
