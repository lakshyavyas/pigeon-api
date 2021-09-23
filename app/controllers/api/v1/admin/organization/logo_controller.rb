# frozen_string_literal: true

module Api
  module V1
    module Admin
      module Organization
        # Organization Logo Controller
        class LogoController < BaseController
          before_action { authenticate roles_config[:default_admin] }
          before_action :create_org_avatar, only: %i[create]
          before_action :delete_org_avatar, only: %i[destroy]

          def create
            render_ok organization, Admin::OrganizationSerializer
          end

          def destroy
            render_ok organization, Admin::OrganizationSerializer
          end

          private

          def delete_org_avatar
            organization&.logo&.detach
          end

          def create_org_avatar
            res = organization.update(org_create_logo_params)
            render_unprocessable_entity organization, Utils::ValidationErrorSerializer unless res
          end

          def org_create_logo_params
            params.permit(:logo)
          end
        end
      end
    end
  end
end
