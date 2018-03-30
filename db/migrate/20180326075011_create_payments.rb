class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.boolean :success
      t.string :card_token
      t.references :user
      t.decimal :amount, default: 0
      t.string :failure_message

      t.timestamps
    end
  end
end
