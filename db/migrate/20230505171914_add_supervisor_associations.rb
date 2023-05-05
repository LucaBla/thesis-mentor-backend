class AddSupervisorAssociations < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :supervisor, foreign_key: { to_table: :users }
    add_reference :themes, :supervisor, foreign_key: { to_table: :users }
  end
end
