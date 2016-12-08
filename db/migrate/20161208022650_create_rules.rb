class CreateRules < ActiveRecord::Migration[5.0]
  def change
    create_table :rules do |t|
      t.string :case, null: false

      t.timestamps
    end
    add_index :rules, :case, unique: true
  end
end
