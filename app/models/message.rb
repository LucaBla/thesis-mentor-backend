class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_create_commit{ broadcast_message }

  private 

  def broadcast_message
    ActionCable.server.broadcast("MessagesChannel", {
      id:,
      content:,
      chat_id:,
      user_id:
    })
  end
end