class Theme < ApplicationRecord
  has_many  :chats
  has_and_belongs_to_many :tags
  belongs_to :supervisor
end
