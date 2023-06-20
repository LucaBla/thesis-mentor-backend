class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :student
  belongs_to :supervisor
  belongs_to :second_supervisor, class_name: 'Supervisor',foreign_key: 'second_supervisor_id', optional: true
  belongs_to :theme
  belongs_to :status
  belongs_to :billing_status

  validate :validate_second_supervisor_type

  private

  def validate_second_supervisor_type
    return if second_supervisor.nil? || second_supervisor.is_a?(Supervisor)

    errors.add(:second_supervisor, 'must be of type Supervisor')
  end
end
