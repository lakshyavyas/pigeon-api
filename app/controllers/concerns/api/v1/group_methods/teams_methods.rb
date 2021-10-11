# frozen_string_literal: true

module Api
  module V1
    module GroupMethods
      module TeamsMethods # :nodoc:
        extend ActiveSupport::Concern

        def t_find_group(params)
          Core::Team.find_by(id: unmask_value(params[:id]))
        end

        # [serializer_params, process_params]
        def t_params_for(action)
          hash = [{ params: { user: user } }, { user: user, group: group }]
          hash[1][:create_team_params] = create_team_params if action == 'create'
          hash[1][:update_team_params] = update_team_params if action == 'update'

          hash
        end

        # [serializer_klass, process_klass]
        def t_klass_for(action)
          [Groups::TeamSerializer, send("t_klass_#{action}")]
        end

        def t_klass_destroy
          Teams::DestroyProcess
        end

        def t_klass_update
          Teams::UpdateProcess
        end

        def t_klass_show
          Teams::ShowProcess
        end

        def t_klass_create
          Teams::CreateProcess
        end

        def t_klass_index
          Teams::ListProcess
        end

        def create_team_params
          params.permit(:name, :meta_data)
        end

        def update_team_params
          params.permit(:name, :meta_data)
        end
      end
    end
  end
end
