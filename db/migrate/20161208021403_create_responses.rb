class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.string :msgtype
      t.string :message

      t.timestamps
    end
  end
end
