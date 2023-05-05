class AddStatusAssociations < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :status, foreign_key: true
  end
end
