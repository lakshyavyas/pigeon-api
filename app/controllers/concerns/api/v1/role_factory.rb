# frozen_string_literal: true

module Api
  module V1
    module RoleFactory # :nodoc:
      extend ActiveSupport::Concern

      def filter_roles(user, resource_type, logical_name)
        return '*' if org_admin?(user) || org_owner?(user)

        Core::Role.where(resource_type: resource_type, logical_name: logical_name).pluck(:resource_id)
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
        !Core::Role.role_levels[role_name].nil?
      end

      def org_admin?(user)
        user.roles.admin.where(logical_name: 'organization', resource: Core::Organization.first).count.positive?
      end

      def org_owner?(user)
        user.roles.owner.where(logical_name: 'organization', resource: Core::Organization.first).count.positive?
      end

      def resource_admin?(user, resource_name, resource)
        user.roles.admin.where(logical_name: resource_name, resource: resource).count.positive?
      end

      def resource_owner?(user, resource_name, resource)
        user.roles.owner.where(logical_name: resource_name, resource: resource).count.positive?
      end

      def resource_user?(user, resource_name, resource)
        user.roles.member.where(logical_name: resource_name, resource: resource).count.positive?
      end

      def get_role_arn(user, logical_name, resource)
        role = get_role(user, logical_name, resource)
        role&.role_arn
      end

      def get_role(user, logical_name, resource)
        return nil if user.nil?

        role = user.roles.owner.where(logical_name: logical_name, resource: resource).first
        role ||= user.roles.admin.where(logical_name: logical_name, resource: resource).first
        role || user.roles.member.where(logical_name: logical_name, resource: resource).first
      end
    end
  end
end
