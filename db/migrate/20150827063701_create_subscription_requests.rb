class CreateSubscriptionRequests < ActiveRecord::Migration
  def change
    create_table :subscription_requests do |t|
      t.string :email, null: false
      t.string :token, null: false

      t.timestamps null: false
    end

    add_index :subscription_requests, :token
  end
end
