class AddQuantityOfGame < ActiveRecord::Migration
  def self.up
    add_column :games, :quantity, :integer
  end

  def self.down
    remove_column :games, :quantity
  end
end
