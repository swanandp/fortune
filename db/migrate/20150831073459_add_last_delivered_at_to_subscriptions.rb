class AddLastDeliveredAtToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_delivered_at, :timestamp
  end
end
