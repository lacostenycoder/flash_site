class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :total, default: 0
      t.decimal :loyality_discount
      t.references :user
      t.integer :status
      t.references :address
      t.timestamps
    end
  end
end
