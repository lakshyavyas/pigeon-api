# frozen_string_literal: true

Role.create(title: 'Admin', id: 1, description: 'Default admin role', scope: roles_config[:default_admin]) unless Role.exists?(id: 1)
Role.create(title: 'User', id: 2, description: 'Default normal role', scope: roles_config[:default_user]) unless Role.exists?(id: 2)

