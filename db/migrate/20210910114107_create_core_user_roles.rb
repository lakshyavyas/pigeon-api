# frozen_string_literal: true

class CreateCoreUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.user_roles' do |t|
      t.references :user, null: false, foreign_key: true
      t.references :roleable, polymorphic: true, null: false
      t.string :logical_name, limit: 255
      t.integer :role_level

      t.timestamps
    end
  end
end
