# frozen_string_literal: true

Role.create(title: 'Admin', id: 1, description: 'Default admin role', scope: 'admin::*') unless Role.exists?(id: 1)
User.create(first_name: 'Admin', last_name: 'User', email: 'admin@example.com') unless User.exists?(id: 1)
