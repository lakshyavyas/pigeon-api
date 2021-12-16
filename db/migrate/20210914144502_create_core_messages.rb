class CreateCoreMessages < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.messages' do |t|
      t.references :recipient, polymorphic: true, null: false
      t.references :sender, polymorphic: true, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
