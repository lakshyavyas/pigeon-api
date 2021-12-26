# frozen_string_literal: true

# Api::V1::Auth::Access Serializer
module Api
  module V1
    module Groups
      class UserSerializer < Mutils::Serialization::BaseSerializer # :nodoc:
        class << self
          include RoleFactory
        end

        attributes :first_name, :last_name, :email, :obj_id
        attribute :full_name do |obj|
          "#{obj.first_name} #{obj.last_name}"
        end
        attribute :avatar, &:avatar_urls
        attribute :role do |obj, params|
          get_role_arn(obj, params[:logical_name], params[:group])
        end
      end
    end
  end
end
