# frozen_string_literal: true

# Api::V1::Utils::ValidationError Serializer
module Api
  module V1
    module Utils
      # used to render validation error from active record
      class ValidationErrorSerializer < Mutils::Serialization::BaseSerializer
        attribute :message do
          'Validation Error'
        end
        attribute :error_message do |obj|
          obj.errors.full_messages.join(', ')
        end
      end
    end
  end
end
