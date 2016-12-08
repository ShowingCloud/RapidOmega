class CreateResponseRules < ActiveRecord::Migration[5.0]
  def change
    create_table :response_rules do |t|

      t.timestamps
    end
  end
end
