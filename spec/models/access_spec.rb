# frozen_string_literal: true

# == Schema Information
#
# Table name: accesses
#
#  id           :bigint           not null, primary key
#  access_token :string
#  active       :boolean          default(TRUE)
#  expires_at   :datetime
#  renew_token  :string
#  token_type   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_accesses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Access, type: :model do
  it { is_expected.to validate_presence_of(:token_type) }
  it { is_expected.to belong_to(:user) }
end
