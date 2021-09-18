# frozen_string_literal: true

module Api
  module V1
    # Access module to check access_token and renew token
    module Accesses
      extend ActiveSupport::Concern

      def authenticate
        access_token = request.headers['HTTP_ACCESS_TOKEN']
        @access = Access.find_by(access_token: access_token)
        @user = access&.user
        render_unauthorized standard_error('app.error.unauthorized'), Utils::ErrorSerializer unless access && user
      end

      private

      def render_obj(obj, serializer_klass, status)
        render json: serializer_klass.new(obj), status: status
      end
    end
  end
end
