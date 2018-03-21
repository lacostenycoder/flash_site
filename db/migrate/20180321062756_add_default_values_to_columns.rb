class AddDefaultValuesToColumns < ActiveRecord::Migration[5.2]
  def change
    change_column_default :deals, :price, 0.00
    change_column_default :deals, :discounted_price, 0.00
    change_column_default :line_items, :price, 0.00
    change_column_default :orders, :loyality_discount, 0.00
  end
end
