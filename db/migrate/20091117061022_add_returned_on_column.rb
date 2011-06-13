class AddReturnedOnColumn < ActiveRecord::Migration
  def self.up
    add_column :games_users, :returned_at, :datetime
  end

  def self.down
    remove_column :games_users, :returned_at
  end
end
