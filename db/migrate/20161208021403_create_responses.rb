class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.integer :msgtype, null: false
      t.string :message

      t.timestamps
    end
  end
end
