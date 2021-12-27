# frozen_string_literal: true

# == Schema Information
#
# Table name: core.roles
#
#  id            :integer          not null, primary key
#  resource_type :string           not null
#  resource_id   :integer          not null
#  roleable_type :string           not null
#  roleable_id   :integer          not null
#  logical_name  :string(255)
#  role_level    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_core.roles_on_resource  (resource_type,resource_id)
#  index_core.roles_on_roleable  (roleable_type,roleable_id)
#

module Core
  class Role < ApplicationRecord
    enum role_level: %i[owner admin member]

    belongs_to :roleable, polymorphic: true
    belongs_to :resource, polymorphic: true
    validates :logical_name, presence: true
    validates :role_level, presence: true

    after_commit :save_role_arn

    def build_role_arn
      "#{role_level}::#{roleable_name}::#{logical_name}::#{mask_value(roleable_id)}"
    end

    def owner?
      role_level == 'owner'
    end

    private

    def save_role_arn
      update(role_arn: build_role_arn) if build_role_arn != role_arn
    end

    def roleable_name
      roleable.class_name.gsub('core::', '')
    end
  end
end
