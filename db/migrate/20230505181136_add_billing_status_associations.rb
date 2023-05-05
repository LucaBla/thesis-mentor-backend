class AddBillingStatusAssociations < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :billing_status, foreign_key: true
  end
end
