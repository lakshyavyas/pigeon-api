# == Schema Information
#
# Table name: core.groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :string(255)      default("Core::Team")
#  meta_data  :jsonb            default("{}"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_core.groups_on_meta_data  (meta_data)
#  index_core.groups_on_type       (type)
#

# frozen_string_literal: true

module Core
  class Channel < Group # :nodoc:
    def public?
      meta_data[:is_public] == true
    end
  end
end
