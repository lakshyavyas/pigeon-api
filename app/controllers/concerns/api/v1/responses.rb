# frozen_string_literal: true

module Api
  module V1
    # Responses module to render json
    module Responses
      extend ActiveSupport::Concern

      %i[ok created unprocessable_entity internal_server_error bad_request unauthorized].each do |name|
        define_method :"render_#{name}" do |obj, serializer_klass, serializer_params = {}|
          render_obj obj, serializer_klass, serializer_params, name.to_sym
        end
      end

      private

      def render_obj(obj, serializer_klass, serializer_params, status)
        render json: serializer_klass.new(obj, serializer_params), status: status
      end
    end
  end
end
