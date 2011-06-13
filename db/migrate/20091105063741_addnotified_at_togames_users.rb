class AddnotifiedAtTogamesUsers < ActiveRecord::Migration
  def self.up
		add_column :games_users, :notified_at , :datetime
  end

  def self.down
		remove_column :games_users, :notified_at, :datetime
  end
end
