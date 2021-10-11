# frozen_string_literal: true

module Api
  module V1
    module OrganizationSettingsMethods # :nodoc:
      include RoleFactory

      private

      def check_org_owner_admin
        res = org_admin?(user) || org_owner?(user)
        render_unauthorized standard_error('app.error.unauthorized'), Utils::ErrorSerializer unless res
      end
    end
  end
end
