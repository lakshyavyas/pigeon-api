# frozen_string_literal: true

module Api
  module V1
    # Access module to check access_token and renew token
    module Errors
      extend ActiveSupport::Concern

      def standard_error(i18n_key)
        StandardError.new(I18n.t(i18n_key))
      end
    end
  end
end
