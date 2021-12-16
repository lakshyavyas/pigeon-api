class CreateCoreSimpleAuths < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.simple_auths' do |t|
      t.string :password_digest
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
