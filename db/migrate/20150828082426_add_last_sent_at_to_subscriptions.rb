class AddLastSentAtToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_sent_at, :timestamp
  end
end
