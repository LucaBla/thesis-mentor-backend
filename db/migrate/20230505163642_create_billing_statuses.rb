class CreateBillingStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :billing_statuses do |t|

      t.string :title
      t.timestamps
    end
  end
end
