# frozen_string_literal: true

module Api
  module V1
    module Auth
      # Simple Auth controller
      class SimpleAuthController < BaseController
        before_action :authorize_user, :gen_access, only: :create
        before_action :authenticate, :deactivate_token, only: :destroy

        def create
          render_created access, Auth::AccessSerializer
        end

        def destroy
          render_ok nil, Auth::AccessSerializer
        end

        private

        def authorize_user
          simple_auth = User.find_by(email: params[:username])&.simple_auth&.authenticate(params[:password])
          if simple_auth
            @user = simple_auth.user
            return
          end

          render_bad_request standard_error('app.error.bad_request'), Utils::ErrorSerializer
        end

        def gen_access
          @access = user.accesses.create(token_type: :api)
          render_server_error standard_error('app.error.server_error'), Utils::ErrorSerializer unless access
        end

        def deactivate_token
          res = access.update(active: false)
          render_server_error standard_error('app.error.server_error'), Utils::ErrorSerializer unless res
        end
      end
    end
  end
end
