# frozen_string_literal: true

module Api
  module V1
    module GroupMethods # :nodoc:
      extend ActiveSupport::Concern
      include RoleFactory
      include ApiCommons::CommonMethods
      include TeamsMethods
      include ChannelsMethods

      private

      def perform_action
        process_obj = process_klass.new(process_params)
        self.group = process_obj.perform
        set_params
        send process_obj.error_method, process_obj.error, process_obj.error_serializer unless group
      end
    end
  end
end
