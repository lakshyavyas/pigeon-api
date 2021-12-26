class CreateCoreGuests < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.guests' do |t|
      t.jsonb :meta_data, null: false, default: {}
      t.jsonb :identity, null: false, default: {}

      t.timestamps
    end
  end
end
