class AddIsActiveColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :activation_token, :is_active
    change_column :users, :is_active, :boolean
  end

  def self.down
    change_column :users, :is_active, :string
    rename_column :users, :is_active, :activation_token
  end
end
