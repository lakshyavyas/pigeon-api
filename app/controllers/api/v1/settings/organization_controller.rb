# frozen_string_literal: true

module Api
  module V1
    module Settings
      # Organization controller
      class OrganizationController < BaseController
        include OrganizationSettingsMethods
        before_action :authenticate, only: %i[index update]
        before_action :check_org_owner_admin, :update_organization, only: %i[update]

        def index
          render_ok organization, Iam::OrganizationSerializer
        end

        def update
          # TODO: check admin, owner role
          render_ok organization, Iam::OrganizationSerializer
        end

        private

        def update_organization
          res = organization.update(organization_update_params)
          render_unprocessable_entity organization, Utils::ValidationErrorSerializer unless res
        end

        def organization_update_params
          params.permit(:name)
        end
      end
    end
  end
end
