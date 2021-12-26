# frozen_string_literal: true

# Api::V1::Auth::Access Serializer
module Api
  module V1
    module Groups
      # Teams serializer
      class ChannelSerializer < Mutils::Serialization::BaseSerializer
        class << self
          include RoleFactory
        end

        attributes :name, :obj_id
        attribute :public, &:public?
        attribute :role do |obj, params|
          get_role_arn(params[:user], 'channel', obj)
        end
      end
    end
  end
end
