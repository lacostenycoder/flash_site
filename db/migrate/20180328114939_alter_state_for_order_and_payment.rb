class AlterStateForOrderAndPayment < ActiveRecord::Migration[5.2]
  def change
    change_table :orders do |t|
       t.remove :status
       t.column :state, :string
    end

    change_table :payments do |t|
      t.remove :success
      t.column :state, :string
    end
  end

end
