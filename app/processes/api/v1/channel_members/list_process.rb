# frozen_string_literal: true

module Api
  module V1
    module ChannelMembers
      class ListProcess < DryProcess # :nodoc:
        include RoleFactory
        attr_accessor :group, :user

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
        end

        def work
          self.output = group.roles.map(&:roleable)
        end
      end
    end
  end
end
