# frozen_string_literal: true

module Api
  module V1
    module Teams
      # Process to list teams for the user
      class UpdateProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :group, :update_team_params

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
          self.update_team_params = args[:update_team_params]
        end

        def work
          self.output = group
          self.error = group unless group.update(update_team_params)
        end

        def validation
          check_access
        end

        def check_access
          unless can_write_resource?(user, 'team', group)
            not_allowed_to_access('team', group.obj_id)
            return false
          end

          true
        end
      end
    end
  end
end
