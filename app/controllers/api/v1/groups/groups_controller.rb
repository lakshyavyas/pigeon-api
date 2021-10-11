# frozen_string_literal: true

module Api
  module V1
    module Groups
      class GroupsController < BaseController # :nodoc:
        include GroupMethods

        before_action :authenticate
        before_action :set_group, only: %i[show update destroy]
        before_action :set_klasses, :set_params, :check_values, :perform_action
        attr_accessor :serializer_klass, :serializer_params, :process_klass, :process_params, :group

        def index
          render_ok group, serializer_klass, serializer_params
        end

        def create
          render_created group, serializer_klass, serializer_params
        end

        def show
          render_ok group, serializer_klass, serializer_params
        end

        def destroy
          render_ok nil, serializer_klass, serializer_params
        end

        def update
          render_ok group, serializer_klass, serializer_params
        end
      end
    end
  end
end
