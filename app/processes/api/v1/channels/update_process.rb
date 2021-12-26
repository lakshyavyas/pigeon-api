# frozen_string_literal: true

module Api
  module V1
    module Channels
      # Process to list channels for the user
      class UpdateProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :group, :update_channel_params, :is_public

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
          self.is_public = args[:is_public]
          self.update_channel_params = args[:update_channel_params]
        end

        def work
          self.output = group
          self.error = group unless update_group
        end

        def update_group
          res = group.update(update_channel_params)
          unless is_public.nil?
            group.meta_data[:is_public] = is_public
            res = group.save
          end

          res
        end

        def validation
          check_access
        end

        def check_access
          unless can_write_resource?(user, 'channel', group)
            not_allowed_to_access('channel', group.obj_id)
            return false
          end

          true
        end
      end
    end
  end
end
