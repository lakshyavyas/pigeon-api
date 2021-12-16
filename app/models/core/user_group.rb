# frozen_string_literal: true

# == Schema Information
#
# Table name: core.user_groups
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  group_id   :integer          not null
#  owner      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.user_groups_on_group_id  (group_id)
#  index_core.user_groups_on_user_id   (user_id)
#

module Core
  class UserGroup < ApplicationRecord
    belongs_to :user
    belongs_to :group
  end
end
