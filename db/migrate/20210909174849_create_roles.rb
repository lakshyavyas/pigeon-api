# frozen_string_literal: true

# Create roles table
class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :title
      t.string :description
      t.string :scope

      t.timestamps
    end
  end
end
