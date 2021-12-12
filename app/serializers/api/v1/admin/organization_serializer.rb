# frozen_string_literal: true

# Api::V1::Admin::Organization Serializer
module Api
  module V1
    module Admin
      class OrganizationSerializer < Mutils::Serialization::BaseSerializer
        attributes :name
        attribute :logo, &:logo_urls
      end
    end
  end
end
