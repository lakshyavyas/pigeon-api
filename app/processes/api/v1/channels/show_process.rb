# frozen_string_literal: true

module Api
  module V1
    module Channels
      # Process to list channels for the user
      class ShowProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :group

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
        end

        def work
          unless can_read_resource?(user, 'channel', group)
            not_allowed_to_access('channel', group.obj_id)
            return
          end

          self.output = group
        end
      end
    end
  end
end
