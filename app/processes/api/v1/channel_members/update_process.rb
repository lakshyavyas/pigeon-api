# frozen_string_literal: true

module Api
  module V1
    module ChannelMembers
      class UpdateProcess < DryProcess # :nodoc:
        include RoleFactory
        include UserFactory
        attr_accessor :group, :user, :target_userid, :target_role, :target_role_in_db

        private

        def init
          self.group = args[:group]
          self.user = args[:user]
          self.target_userid = args[:target_userid]
          self.target_role = args[:target_role]
        end

        def work
          self.output = target_role_in_db.user
          self.error = target_role_in_db unless target_role_in_db.update(role_level: target_role)
        end

        def validation
          self.target_role_in_db = get_role(fetch_user(target_userid), 'channel', group)
          check_access &&
            check_target_user &&
            check_role_exits &&
            check_target_role_in_db &&
            check_target_role &&
            check_removing_only_owner
        end

        def check_access
          unless can_write_resource?(user, 'channel', group)
            not_allowed_to_access('channel', group.obj_id)
            return false
          end

          true
        end

        def check_target_user
          unless fetch_user(target_userid)
            resource_to_add_not_exists('user', 'channel', group.obj_id)
            return false
          end

          true
        end

        def check_role_exits
          unless role_name_exists?(target_role)
            validation_error(I18n.t('app.user_roles.invalid'))
            return false
          end

          true
        end

        def check_target_role_in_db
          unless target_role_in_db
            validation_error(I18n.t('app.user_roles.not_exists'))
            return false
          end

          true
        end

        def check_target_role
          if target_role_in_db.role_arn.start_with? target_role
            validation_error(I18n.t('app.user_roles.exists'))
            return false
          end

          true
        end

        def check_removing_only_owner
          if target_role_in_db.owner? && group.owners.count <= 1
            validation_error(I18n.t('app.user_roles.cannot_delete_only_owner'))
            return false
          end

          true
        end
      end
    end
  end
end
