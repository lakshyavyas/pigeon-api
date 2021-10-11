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

# frozen_string_literal: true

module Core
  class Team < Group # :nodoc:
  end
end
