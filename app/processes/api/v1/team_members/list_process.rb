# frozen_string_literal: true

module Api
  module V1
    module TeamMembers
      class ListProcess < DryProcess # :nodoc:
        include RoleFactory
        attr_accessor :group, :user, :userid_to_add, :role_to_add

        private

        def init
          self.user = args[:user]
          self.group = args[:group]
        end

        def work
          self.output = group.users
        end
      end
    end
  end
end
