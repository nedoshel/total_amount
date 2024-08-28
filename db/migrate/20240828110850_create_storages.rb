class CreateStorages < ActiveRecord::Migration[7.2]
  def change
    create_table :storages do |t|
      t.string :name
      t.integer :value
    end
  end
end
