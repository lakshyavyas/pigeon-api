# frozen_string_literal: true

# == Schema Information
#
# Table name: user_groups
#
#  id         :bigint           not null, primary key
#  owner      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_groups_on_group_id  (group_id)
#  index_user_groups_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  it { is_expected.to belong_to(:group) }
  it { is_expected.to belong_to(:user) }
end
