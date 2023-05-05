class Supervisor < User
  has_many :themes
  has_and_belongs_to_many :tags, join_table: :supervisors_tags
  has_many :chats
end
