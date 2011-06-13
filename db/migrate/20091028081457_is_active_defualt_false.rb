class IsActiveDefualtFalse < ActiveRecord::Migration
  def self.up
    change_column :users, :is_active,:boolean,:default => false
  end

  def self.down
    change_column :users ,:is_active,:boolean
  end
end
