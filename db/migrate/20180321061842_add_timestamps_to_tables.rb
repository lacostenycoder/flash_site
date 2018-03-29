class AddTimestampsToTables < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :addresses
    add_timestamps :deals
    add_timestamps :line_items
  end
end
