# frozen_string_literal: true

module Api
  module V1
    module GroupMembersMethods
      module TeamsMethods # :nodoc:
        extend ActiveSupport::Concern

        def t_find_group(params)
          Core::Team.find_by(id: unmask_value(params[:team_id]))
        end

        # [serializer_params, process_params]
        def t_params_for(action)
          hash = [{ params: { user: user, logical_name: 'team', group: group } }, { user: user, group: group }]
          send "t_params_specific_for_#{action}", hash
        end

        def t_params_specific_for_index(hash)
          hash
        end

        def t_params_specific_for_destroy(hash)
          hash[1][:target_userid] = params[:id]
          hash
        end

        def t_params_specific_for_update(hash)
          hash[1][:target_userid] = params[:id]
          hash[1][:target_role] = params[:role]
          hash
        end

        def t_params_specific_for_create(hash)
          hash[1][:target_userid] = params[:user_id]
          hash[1][:target_role] = params[:role]
          hash
        end

        # [serializer_klass, process_klass]
        def t_klass_for(action)
          [Groups::UserSerializer, send("t_klass_#{action}")]
        end

        def t_klass_destroy
          TeamMembers::DestroyProcess
        end

        def t_klass_update
          TeamMembers::UpdateProcess
        end

        def t_klass_create
          TeamMembers::CreateProcess
        end

        def t_klass_index
          TeamMembers::ListProcess
        end
      end
    end
  end
end
