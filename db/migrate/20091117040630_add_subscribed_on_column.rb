class AddSubscribedOnColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :subscribed_on, :date
  end

  def self.down
    remove_column :users, :subscribed_on
  end
end
