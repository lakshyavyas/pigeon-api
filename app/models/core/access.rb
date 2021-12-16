# frozen_string_literal: true

# == Schema Information
#
# Table name: core.accesses
#
#  id           :integer          not null, primary key
#  access_token :string
#  renew_token  :string
#  token_type   :integer
#  expires_at   :datetime
#  active       :boolean          default("true")
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_core.accesses_on_user_id  (user_id)
#

module Core
  class Access < ApplicationRecord
    include Tokenable
    enum token_type: %i[api]

    belongs_to :user
    validates :access_token, presence: true
    validates :renew_token, presence: true
    validates :expires_at, presence: true
    validates :token_type, presence: true
  end
end
