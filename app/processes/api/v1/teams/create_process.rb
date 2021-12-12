# frozen_string_literal: true

module Api
  module V1
    module Teams
      # Process to create teams
      class CreateProcess < DryProcess
        attr_accessor :owner, :create_team_params

        private

        def init
          self.owner = args[:owner]
          self.create_team_params = args[:create_team_params]
        end

        def work
          team = Group.team.new(create_team_params)
          team.meta_data = { owner: owner.id }
          self.error = team.errors unless team.save
        end
      end
    end
  end
end
