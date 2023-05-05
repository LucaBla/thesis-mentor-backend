class Tag < ApplicationRecord
  has_and_belongs_to_many :themes
  has_and_belongs_to_many :supervisors, join_table: :supervisors_tags
end
