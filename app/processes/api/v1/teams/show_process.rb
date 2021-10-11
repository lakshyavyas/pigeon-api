# frozen_string_literal: true

module Api
  module V1
    module Teams
      # Process to list teams for the user
      class ShowProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :group

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
        end

        def work
          unless can_read_resource?(user, 'team', group)
            not_allowed_to_access('team', group.obj_id)
            return
          end

          self.output = group
        end
      end
    end
  end
end
