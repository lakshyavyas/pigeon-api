# frozen_string_literal: true

module Api
  module V1
    module Teams
      # Process to list teams for the user
      class ListProcess < DryProcess
        include RoleFactory
        attr_accessor :user

        private

        def init
          self.user = args[:user]
          self.output = Core::Team
        end

        def work
          ids = filter_roles(user, 'Core::Group', 'team')
          return if ids == '*'

          self.output = output.where(id: ids)
        end
      end
    end
  end
end
