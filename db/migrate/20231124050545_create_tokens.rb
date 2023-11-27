class CreateTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :value, null: false
      t.timestamps
    end
  end
end
