class CreateAmounts < ActiveRecord::Migration[7.2]
  def change
    create_table :amounts do |t|
      t.string :token, null: false
      t.integer :value

      t.timestamps
    end

    add_index :amounts, :token, unique: true
  end
end
