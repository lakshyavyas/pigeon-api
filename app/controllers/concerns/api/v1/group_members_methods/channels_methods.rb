# frozen_string_literal: true

module Api
  module V1
    module GroupMembersMethods
      module ChannelsMethods # :nodoc:
        extend ActiveSupport::Concern

        def ch_find_group(params)
          Core::Channel.find_by(id: unmask_value(params[:channel_id]))
        end

        # [serializer_params, process_params]
        def ch_params_for(action)
          hash = [{ params: { user: user, logical_name: 'channel', group: group } }, { user: user, group: group }]
          send "ch_params_specific_for_#{action}", hash
        end

        def ch_params_specific_for_index(hash)
          hash
        end

        def ch_params_specific_for_destroy(hash)
          hash[1][:target_userid] = params[:id]
          hash
        end

        def ch_params_specific_for_update(hash)
          hash[1][:target_userid] = params[:id]
          hash[1][:target_role] = params[:role]
          hash
        end

        def ch_params_specific_for_create(hash)
          hash[1][:target_userid] = params[:user_id]
          hash[1][:target_role] = params[:role]
          hash
        end

        # [serializer_klass, process_klass]
        def ch_klass_for(action)
          [Groups::UserSerializer, send("ch_klass_#{action}")]
        end

        def ch_klass_destroy
          ChannelMembers::DestroyProcess
        end

        def ch_klass_update
          ChannelMembers::UpdateProcess
        end

        def ch_klass_create
          ChannelMembers::CreateProcess
        end

        def ch_klass_index
          ChannelMembers::ListProcess
        end
      end
    end
  end
end
