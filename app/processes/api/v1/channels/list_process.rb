# frozen_string_literal: true

module Api
  module V1
    module Channels
      # Process to list channels for the user
      class ListProcess < DryProcess
        include RoleFactory
        attr_accessor :user, :is_list_public, :name_query

        private

        def init
          self.user = args[:user]
          self.is_list_public = args[:is_list_public]
          self.name_query = args[:name_query]
          self.output = Core::Channel
        end

        def work
          if is_list_public
            list_public
          else
            list_joined
          end
        end

        def list_public
          self.output = Core::Channel.where('meta_data @> ?', { is_public: true }.to_json)
          self.output = output.search_name(name_query) unless name_query.nil?
        end

        def list_joined
          ids = filter_roles(user, 'Core::Group', 'channel')
          return if ids == '*'

          self.output = output.where(id: ids)
        end
      end
    end
  end
end
