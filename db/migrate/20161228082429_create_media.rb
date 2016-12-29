class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.string :media_id
      t.json :content
      t.string :name
      t.string :url
      t.integer :update_time
      t.integer :media_type

      t.timestamps
    end
    add_index :media, :media_id, unique: true
  end
end
