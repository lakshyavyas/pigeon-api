# frozen_string_literal: true

module Api
  module V1
    module Groups
      class GroupMembersController < BaseController # :nodoc:
        include GroupMembersMethods

        before_action :authenticate
        before_action :set_group
        before_action :set_klasses, :set_params, :check_values, :perform_action
        attr_accessor :serializer_klass, :serializer_params, :process_klass, :process_params, :group, :other_user

        def index
          render_ok other_user, serializer_klass, serializer_params
        end

        def create
          render_created other_user, serializer_klass, serializer_params
        end

        def destroy
          render_ok nil, serializer_klass, serializer_params
        end

        def update
          render_ok other_user, serializer_klass, serializer_params
        end
      end
    end
  end
end
