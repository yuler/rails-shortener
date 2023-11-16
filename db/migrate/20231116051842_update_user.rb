class UpdateUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :email_normalized

    add_column :users, :last_sign_in_at, :datetime
  end
end
