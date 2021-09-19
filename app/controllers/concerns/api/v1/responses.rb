# frozen_string_literal: true

module Api
  module V1
    # Responses module to render json
    module Responses
      extend ActiveSupport::Concern

      def render_ok(obj, serializer_klass)
        render_obj obj, serializer_klass, :ok
      end

      def render_created(obj, serializer_klass)
        render_obj obj, serializer_klass, :created
      end

      def render_unauthorized(obj, serializer_klass)
        render_obj obj, serializer_klass, :unauthorized
      end

      def render_bad_request(obj, serializer_klass)
        render_obj obj, serializer_klass, :bad_request
      end

      def render_server_error(obj, serializer_klass)
        render_obj obj, serializer_klass, :internal_server_error
      end

      def render_unprocessable_entity(obj, serializer_klass)
        render_obj obj, serializer_klass, :unprocessable_entity
      end

      private

      def render_obj(obj, serializer_klass, status)
        render json: serializer_klass.new(obj), status: status
      end
    end
  end
end
