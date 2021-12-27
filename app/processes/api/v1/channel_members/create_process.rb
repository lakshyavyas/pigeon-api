# frozen_string_literal: true

module Api
  module V1
    module ChannelMembers
      class CreateProcess < DryProcess # :nodoc:
        include RoleFactory
        include UserFactory
        attr_accessor :group, :user, :target_userid, :target_role, :target_user

        private

        def init
          self.group = args[:group]
          self.user = args[:user]
          self.target_userid = args[:target_userid]
          self.target_role = args[:target_role]
          self.target_user = fetch_user(target_userid)
        end

        def work
          self.output = fetch_user(target_userid)
          res = output.roles.send(target_role).create(resource: group, logical_name: 'channel')
          self.error = res unless res.persisted?
        end

        def validation
          check_access && check_target_role_in_db && check_role_exits && check_user
        end

        def check_access
          if group.public? && user.id == target_user.id
            return true if target_role == 'member'

            validation_error(I18n.t('app.roles.public_channel_member_only'))
            return false
          end

          unless can_write_resource?(user, 'channel', group)
            not_allowed_to_access('channel', group.obj_id)
            return false
          end

          true
        end

        def check_target_role_in_db
          if get_role(target_user, 'channel', group)
            validation_error(I18n.t('app.roles.exists'))
            return false
          end

          true
        end

        def check_role_exits
          unless role_name_exists?(target_role)
            validation_error(I18n.t('app.roles.invalid'))
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
