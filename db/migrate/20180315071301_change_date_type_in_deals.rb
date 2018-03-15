class ChangeDateTypeInDeals < ActiveRecord::Migration[5.2]
  def change
    change_column :deals, :publish_date, :date
  end
end
