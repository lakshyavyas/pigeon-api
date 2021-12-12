# frozen_string_literal: true

module Api
  module V1
    module Iam
      # User profile controller
      class MeController < BaseController
        before_action :authenticate
        before_action :update_user_profile, only: %i[update]

        def index
          render_ok user, Iam::MeSerializer
        end

        def update
          render_ok user, Iam::MeSerializer
        end

        private

        def update_user_profile
          res = user.update(user_profile_update_params)
          render_unprocessable_entity user, Utils::ValidationErrorSerializer unless res
        end

        def user_profile_update_params
          params.permit(:first_name, :last_name)
        end
      end
    end
  end
end
