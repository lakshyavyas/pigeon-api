# frozen_string_literal: true

# Create users table
class CreateCoreUsers < ActiveRecord::Migration[6.1]

  def change
    create_table 'core.users', schema: 'core' do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :email, limit: 255

      t.timestamps
    end
  end
end
