# frozen_string_literal: true

module Api
  module V1
    module Iam
      # User Avatar controller
      class AvatarController < BaseController
        before_action :authenticate
        before_action :create_user_avatar, only: %i[create]
        before_action :delete_user_avatar, only: %i[destroy]

        def create
          render_ok user, Iam::MeSerializer
        end

        def destroy
          render_ok user, Iam::MeSerializer
        end

        private

        def delete_user_avatar
          user&.avatar&.detach
        end

        def create_user_avatar
          res = user.update(user_create_avatar_params)
          render_unprocessable_entity user, Utils::ValidationErrorSerializer unless res
        end

        def user_create_avatar_params
          params.permit(:avatar)
        end
      end
    end
  end
end
