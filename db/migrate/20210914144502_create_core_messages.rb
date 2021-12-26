class CreateCoreMessages < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.messages' do |t|
      t.references :recipient, polymorphic: true, null: false
      t.references :sender, polymorphic: true, null: false
      t.jsonb :meta_data, null: false, default: {}

      t.timestamps
    end
  end
end
