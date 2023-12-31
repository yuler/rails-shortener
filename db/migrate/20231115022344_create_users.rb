class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false
      t.datetime :last_sign_in_at
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
