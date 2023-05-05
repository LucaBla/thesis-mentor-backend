class AddThemeAssociations < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :theme, foreign_key: true
  end
end
