# frozen_string_literal: true

# Api::V1::Utils::Error Serializer
module Api
  module V1
    module Utils
      class ErrorSerializer < Mutils::Serialization::BaseSerializer
        attributes :message
        attribute :backtrace, if: proc { ENV.fetch('LOG_ERRORS', 'false') == 'true' }
      end
    end
  end
end
