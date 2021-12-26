# frozen_string_literal: true

module Api
  module V1
    module GroupMethods
      module ChannelsMethods # :nodoc:
        extend ActiveSupport::Concern

        def ch_find_group(params)
          Core::Channel.find_by(id: unmask_value(params[:id]))
        end

        # [serializer_params, process_params]
        def ch_params_for(action)
          hash = [{ params: { user: user } }, { user: user, group: group }]
          send "ch_params_specific_for_#{action}", hash
        end

        def ch_params_specific_for_index(hash)
          hash[1][:is_list_public] = request.path.end_with?('public')
          hash[1][:name_query] = params[:q] || nil
          hash
        end

        def ch_params_specific_for_show(hash)
          hash
        end

        def ch_params_specific_for_destroy(hash)
          hash
        end

        def ch_params_specific_for_update(hash)
          hash[1][:is_public] = params[:is_public]
          hash[1][:update_channel_params] = update_channel_params
          hash
        end

        def ch_params_specific_for_create(hash)
          hash[1][:is_public] = params[:is_public]
          hash[1][:create_channel_params] = create_channel_params
          hash
        end

        # [serializer_klass, process_klass]
        def ch_klass_for(action)
          [Groups::ChannelSerializer, send("ch_klass_#{action}")]
        end

        def ch_klass_destroy
          Channels::DestroyProcess
        end

        def ch_klass_update
          Channels::UpdateProcess
        end

        def ch_klass_show
          Channels::ShowProcess
        end

        def ch_klass_create
          Channels::CreateProcess
        end

        def ch_klass_index
          Channels::ListProcess
        end

        def create_channel_params
          params.permit(:name, :meta_data)
        end

        def update_channel_params
          params.permit(:name, :meta_data)
        end
      end
    end
  end
end
