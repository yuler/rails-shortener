class AddCodeToLink < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :code, :string
    add_index :links, :code, unique: true
  end
end
