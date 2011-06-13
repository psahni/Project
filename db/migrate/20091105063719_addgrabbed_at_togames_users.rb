class AddgrabbedAtTogamesUsers < ActiveRecord::Migration
  def self.up
		add_column :games_users, :grabbed_at, :datetime
  end

  def self.down
		remove_column :games_users, :grabbed_at, :datetime
  end
end
