class AddColumnToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :order
  end
end
