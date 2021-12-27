# frozen_string_literal: true

module Api
  module V1
    module Teams
      # Process to create teams
      class CreateProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :create_team_params

        private

        def init
          self.user = args[:user]
          self.create_team_params = args[:create_team_params]
        end

        def work
          team = Core::Team.new(create_team_params)
          team.meta_data = { owner: user.id }
          if team.save
            user.roles.owner.create(resource: team, logical_name: 'team')
            self.output = team
          else
            self.error = team
          end
        end
      end
    end
  end
end
