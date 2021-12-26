class CreateCoreGroups < ActiveRecord::Migration[6.1]
  def up
    create_table 'core.groups' do |t|
      t.string :name, limit: 255
      t.string :type, limit: 255, default: 'Core::Team'
      t.jsonb :meta_data, null: false, default: {}

      t.timestamps
    end
    add_index 'core.groups', :type
    add_index 'core.groups', :meta_data, using: :gin
    add_index 'core.groups', :name, using: :gist, opclass: {name: :gist_trgm_ops}
  end

  def down
    drop_table 'core.groups'
  end
end
