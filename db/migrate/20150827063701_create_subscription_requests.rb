class CreateSubscriptionRequests < ActiveRecord::Migration
  def change
    create_table :subscription_requests do |t|
      t.string :email
      t.string :token
      t.timestamp :valid_until

      t.timestamps null: false
    end
  end
end
