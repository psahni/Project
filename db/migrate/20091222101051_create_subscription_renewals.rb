class CreateSubscriptionRenewals < ActiveRecord::Migration
  def self.up
    create_table :subscription_renewals do |t|
      t.date :renewed_on
      t.integer :user_id
    end
  end

  def self.down
    drop_table :subscription_renewals
  end
end
