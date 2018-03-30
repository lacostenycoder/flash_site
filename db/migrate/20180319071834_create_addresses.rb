class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user
      t.references :country
      t.references :state
      t.string :city
      t.string :street1
      t.string :street2
      t.string :pincode
    end
  end
end
