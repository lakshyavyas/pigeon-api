# frozen_string_literal: true

# == Schema Information
#
# Table name: core.user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  role_arn   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.user_roles_on_user_id  (user_id)
#

module Core
  class UserRole < ApplicationRecord
    belongs_to :user
    validates :role_arn, presence: true
  end
end
