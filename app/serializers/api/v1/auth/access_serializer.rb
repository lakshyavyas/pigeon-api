# frozen_string_literal: true

# Api::V1::Auth::Access Serializer
module Api
  module V1
    module Auth
      class AccessSerializer < Mutils::Serialization::BaseSerializer
        attributes :access_token, :renew_token, :expires_at
      end
    end
  end
end
