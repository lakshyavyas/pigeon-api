# frozen_string_literal: true

module Api
  module V1
    module RoleFactory # :nodoc:
      extend ActiveSupport::Concern

      def filter_roles(user, resource_type, logical_name)
        return '*' if org_admin?(user) || org_owner?(user)

        Core::UserRole.where(roleable_type: resource_type, logical_name: logical_name).pluck(:roleable_id)
      end

      def can_write_resource?(user, logical_name, resource)
        org_owner?(user) ||
          org_admin?(user) ||
          resource_admin?(user, logical_name, resource) ||
          resource_owner?(user, logical_name, resource)
      end

      def can_read_resource?(user, logical_name, resource)
        role_exits?(user, logical_name, resource)
      end

      def role_exits?(user, logical_name, resource)
        resource_user?(user, logical_name, resource) || can_write_resource?(user, logical_name, resource)
      end

      def role_name_exists?(role_name)
        !Core::UserRole.role_levels[role_name].nil?
      end

      def org_admin?(user)
        user.user_roles.admin.where(logical_name: 'organization', roleable: Core::Organization.first).count.positive?
      end

      def org_owner?(user)
        user.user_roles.owner.where(logical_name: 'organization', roleable: Core::Organization.first).count.positive?
      end

      def resource_admin?(user, resource_name, resource)
        user.user_roles.admin.where(logical_name: resource_name, roleable: resource).count.positive?
      end

      def resource_owner?(user, resource_name, resource)
        user.user_roles.owner.where(logical_name: resource_name, roleable: resource).count.positive?
      end

      def resource_user?(user, resource_name, resource)
        user.user_roles.member.where(logical_name: resource_name, roleable: resource).count.positive?
      end

      def get_role_arn(user, logical_name, resource)
        role = get_role(user, logical_name, resource)
        role&.role_arn
      end

      def get_role(user, logical_name, resource)
        return nil if user.nil?

        role = user.user_roles.owner.where(logical_name: logical_name, roleable: resource).first
        role ||= user.user_roles.admin.where(logical_name: logical_name, roleable: resource).first
        role || user.user_roles.member.where(logical_name: logical_name, roleable: resource).first
      end
    end
  end
end
