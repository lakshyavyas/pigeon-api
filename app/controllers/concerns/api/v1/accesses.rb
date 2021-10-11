# frozen_string_literal: true

module Api
  module V1
    # Access module to check access_token and renew token
    module Accesses
      extend ActiveSupport::Concern

      def authenticate
        access_token = request.headers['HTTP_ACCESS_TOKEN']
        @access = Core::Access.find_by(access_token: access_token)
        @user = access&.user
        @organization = Core::Organization.first
        check_access_token
      rescue StandardError => e
        render_unauthorized e, Utils::ErrorSerializer
      end

      protected

      def check_access_token
        raise standard_error('app.error.unauthorized') unless access && user
        raise standard_error('app.error.access_token_expired') if access.expired?
        raise standard_error('app.error.access_token_inactive') if access.inactive?
      end
    end
  end
end
