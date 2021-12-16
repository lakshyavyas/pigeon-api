class CreateCoreUserGroups < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.user_groups' do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.boolean :owner

      t.timestamps
    end
  end
end
