class AddSecondSupervisorToChats < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :second_supervisor, foreign_key: { to_table: :users }
  end
end
