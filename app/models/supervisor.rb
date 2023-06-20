class Supervisor < User
  has_many :themes
  has_and_belongs_to_many :tags, join_table: :supervisors_tags
  has_many :chats
  has_many :second_chats, class_name: 'Chat',foreign_key: 'second_supervisor_id'

  validate :unique_tags

  private

  def unique_tags
    if tags.size != tags.uniq.size
      errors.add(:tags, 'Ein Supervisor kann jedes Tag nur einmal haben')
    end
  end
end