# frozen_string_literal: true

module Api
  module V1
    module Settings
      # Organization controller
      class OrganizationController < BaseController
        before_action only: [:update] do
          authenticate(roles_config[:default_admin])
        end
        before_action :authenticate, only: %i[index]
        before_action :update_organization, only: %i[update]

        def index
          render_ok organization, Iam::OrganizationSerializer
        end

        def update
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
