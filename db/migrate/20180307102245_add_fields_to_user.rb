class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_token_set_at, :datetime
  end
end
