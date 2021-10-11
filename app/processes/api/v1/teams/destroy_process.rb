# frozen_string_literal: true

module Api
  module V1
    module Teams
      # Process to list teams for the user
      class DestroyProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :group

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
        end

        def work
          self.output = group
          group.roles.destroy_all
          group.destroy
        end

        def validation
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
