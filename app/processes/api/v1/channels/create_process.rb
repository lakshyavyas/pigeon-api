# frozen_string_literal: true

module Api
  module V1
    module Channels
      # Process to create channels
      class CreateProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :create_channel_params, :is_public

        private

        def init
          self.user = args[:user]
          self.is_public = args[:is_public] || false
          self.create_channel_params = args[:create_channel_params]
        end

        def work
          channel = Core::Channel.new(create_channel_params)
          channel.meta_data = { owner: user.id, public: is_public }
          if channel.save
            user.roles.owner.create(resource: channel, logical_name: 'channel')
            self.output = channel
          else
            self.error = channel
          end
        end
      end
    end
  end
end
