class AlterColumnResponseMsgtype < ActiveRecord::Migration[5.0]
  def change
    change_column :responses, :msgtype, :integer
    change_column_null :responses, :msgtype, false
  end
end
