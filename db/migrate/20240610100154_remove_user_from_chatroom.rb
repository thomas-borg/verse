class RemoveUserFromChatroom < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :chatroom, index: true, foreign_key: true
    drop_table :chatrooms
    add_reference :messages, :activity, index: true, foreign_key: true
  end
end
