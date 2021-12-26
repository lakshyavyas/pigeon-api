# frozen_string_literal: true

module Api
  module V1
    module UserFactory # :nodoc:
      extend ActiveSupport::Concern

      def fetch_user(user_obj_id)
        Core::User.find_by_obj_id(user_obj_id)
      end
    end
  end
end
