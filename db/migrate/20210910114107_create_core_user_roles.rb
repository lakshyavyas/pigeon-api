# frozen_string_literal: true

class CreateCoreUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.user_roles' do |t|
      t.references :user, null: false, foreign_key: true
      t.string :role_arn

      t.timestamps
    end
  end
end
