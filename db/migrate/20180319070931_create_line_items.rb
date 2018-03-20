class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :order
      t.references :deal
      t.decimal :price
    end
  end
end
