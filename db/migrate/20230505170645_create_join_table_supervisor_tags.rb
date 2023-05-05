class CreateJoinTableSupervisorTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :supervisors, :tags do |t|
      t.index [:supervisor_id, :tag_id]
      t.index [:tag_id, :supervisor_id]
    end
  end
end
