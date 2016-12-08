class AddColumnToResponseRule < ActiveRecord::Migration[5.0]
  def change
    add_column :response_rules, :rule_id, :integer
    add_column :response_rules, :response_id, :integer
  end
end
