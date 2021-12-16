class CreateCoreAccesses < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.accesses' do |t|
      t.string :access_token
      t.string :renew_token
      t.integer :token_type
      t.datetime :expires_at
      t.boolean :active, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
