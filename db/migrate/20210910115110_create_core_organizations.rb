class CreateCoreOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table 'core.organizations' do |t|
      t.string :name

      t.timestamps
    end
  end
end
