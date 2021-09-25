# frozen_string_literal: true

module Api
  module V1
    module UserRoles
      # Validate User role against required role
      class ValidateProcess < DryProcess
        include Errors

        attr_accessor :role_arn, :user

        def init
          self.role_arn = args[:role]
          self.user = args[:user]
        end

        def work
          res = user.user_roles.map(&:role_arn).include?(role_arn)
          self.error = standard_error('app.error.unauthorized') unless res
        end
      end
    end
  end
end
