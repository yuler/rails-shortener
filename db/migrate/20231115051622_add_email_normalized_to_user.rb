class AddEmailNormalizedToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email_normalized, :string
    add_index :users, :email_normalized, unique: true
  end
end
