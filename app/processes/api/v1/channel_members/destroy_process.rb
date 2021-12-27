# frozen_string_literal: true

module Api
  module V1
    module ChannelMembers
      class DestroyProcess < DryProcess # :nodoc:
        include RoleFactory
        include UserFactory
        attr_accessor :group, :user, :target_userid, :target_user, :target_role_in_db

        private

        def init
          self.group = args[:group]
          self.user = args[:user]
          self.target_userid = args[:target_userid]
          self.target_user = fetch_user(target_userid)
          self.target_role_in_db = get_role(target_user, 'channel', group)
        end

        def work
          target_role_in_db.destroy
        end

        def validation
          check_access && check_user && check_target_role_in_db && check_removing_only_owner
        end

        def check_removing_only_owner
          if target_role_in_db.owner? && group.owners.count <= 1
            validation_error(I18n.t('app.roles.cannot_delete_only_owner'))
            return false
          end

          true
        end

        def check_target_role_in_db
          unless target_role_in_db
            validation_error(I18n.t('app.roles.not_exists'))
            return false
          end

          true
        end

        def check_access
          removing_self = target_user&.id == user.id
          unless removing_self || can_write_resource?(user, 'channel', group)
            not_allowed_to_access('channel', group.obj_id)
            return false
          end

          true
        end

        def check_user
          unless target_user
            resource_to_add_not_exists('user', 'channel', group.obj_id)
            return false
          end

          true
        end
      end
    end
  end
end
