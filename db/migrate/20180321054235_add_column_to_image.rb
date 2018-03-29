class AddColumnToImage < ActiveRecord::Migration[5.2]
  def change

    change_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.timestamps
    end
    add_index :images, [:imageable_id, :imageable_type]

  end
end
