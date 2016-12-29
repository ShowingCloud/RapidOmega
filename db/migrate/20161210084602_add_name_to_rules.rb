class AddNameToRules < ActiveRecord::Migration[5.0]
  def change
    add_column :rules, :name, :string
    change_column_null :rules, :name, false
  end
end
