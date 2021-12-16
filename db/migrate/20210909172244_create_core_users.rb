# frozen_string_literal: true

# Create users table
class CreateCoreUsers < ActiveRecord::Migration[6.1]

  def change
    create_table 'core.users', schema: 'core' do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
  end
end
