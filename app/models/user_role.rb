# frozen_string_literal: true

# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_roles_on_role_id  (role_id)
#  index_user_roles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (user_id => users.id)
#
class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  def allowed?(param_role)
    normal_user_check?(param_role) || admin_user_check?(param_role)
  end

  def admin_user_check?(param_role)
    (role.scope.starts_with?(roles_config[:default_admin]) && param_role.starts_with?(roles_config[:default_admin])) ||
      (role.scope.starts_with?(roles_config[:default_admin]) && param_role.starts_with?(roles_config[:default_user]))
  end

  def normal_user_check?(param_role)
    role.scope.starts_with?(roles_config[:default_user]) && param_role.starts_with?(roles_config[:default_user])
  end
end
