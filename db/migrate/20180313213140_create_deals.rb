class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.decimal :discounted_price
      t.integer :quantity
      t.datetime :publish_date
      t.integer :state
      t.string :code
      t.bigint :created_by
    end
  end
end
