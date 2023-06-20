class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :student
  belongs_to :supervisor
  belongs_to :theme
  belongs_to :status
  belongs_to :billing_status
end
