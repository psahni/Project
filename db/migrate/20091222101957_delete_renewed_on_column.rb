class DeleteRenewedOnColumn < ActiveRecord::Migration
  def self.up
    remove_column :users, :renewed_on
  end

  def self.down
    add_column :users, :renewed_on, :date
  end
end
