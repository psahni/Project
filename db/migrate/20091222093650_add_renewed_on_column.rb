class AddRenewedOnColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :renewed_on, :date
  end

  def self.down
    remove_column :users, :renewed_on
  end
end
