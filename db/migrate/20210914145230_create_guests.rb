class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.jsonb :meta_data
      t.jsonb :identity

      t.timestamps
    end
  end
end
