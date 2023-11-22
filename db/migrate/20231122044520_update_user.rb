class UpdateUser < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :last_sign_in_at, :last_logged_at
  end
end
