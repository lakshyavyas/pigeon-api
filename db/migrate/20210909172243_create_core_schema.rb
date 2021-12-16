# frozen_string_literal: true

# Create users table
class CreateCoreSchema < ActiveRecord::Migration[6.1]

  def change
    create_schema 'core' unless schema_exists?('core')
  end

  def down
    drop_schema 'core' if schema_exists?('core')
  end
end
