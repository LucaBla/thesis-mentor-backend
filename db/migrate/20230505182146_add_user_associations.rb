class AddUserAssociations < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :user, foreign_key: true
    add_reference :chats, :student, foreign_key: { to_table: :users }
  end
end
