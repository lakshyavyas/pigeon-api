# frozen_string_literal: true

# Api::V1::Iam::Me Serializer
module Api
  module V1
    module Iam
      # User Profile Serializer
      class MeSerializer < Mutils::Serialization::BaseSerializer
        attributes :first_name, :last_name, :email
        attribute :full_name do |obj|
          "#{obj.first_name} #{obj.last_name}"
        end
        attribute :avatar, &:avatar_urls
      end
    end
  end
end
