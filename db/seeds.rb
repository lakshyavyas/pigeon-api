# frozen_string_literal: true

Role.create(title: 'Admin', id: 1, description: 'Default admin role', scope: 'admin::*') unless Role.exists?(id: 1)
