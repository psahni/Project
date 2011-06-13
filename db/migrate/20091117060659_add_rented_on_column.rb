class AddRentedOnColumn < ActiveRecord::Migration
  def self.up
    add_column :games_users, :rented_at, :datetime
  end

  def self.down
    remove_column :games_users, :rented_at
  end
end
