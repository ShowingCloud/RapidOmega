class ChangeToRules < ActiveRecord::Migration[5.0]
  def change
    remove_index :rules, column: :case
    rename_column :rules, :case, :event
    add_column :rules, :keyword, :string
    add_column :rules, :fullmatch, :boolean, default: true
    add_index :rules, [:event, :keyword], :unique => true
  end
end
