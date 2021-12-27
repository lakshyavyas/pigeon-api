# frozen_string_literal: true

class CreateCoreRoles < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.roles' do |t|
      t.references :resource, polymorphic: true, null: false
      t.references :roleable, polymorphic: true, null: false
      t.string :logical_name, limit: 255
      t.string :role_arn, limit: 255
      t.integer :role_level

      t.timestamps
    end
  end
end
