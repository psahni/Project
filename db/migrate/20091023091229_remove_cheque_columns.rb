class RemoveChequeColumns < ActiveRecord::Migration
  def self.up
    remove_column :users, :cheque_no
    remove_column :users, :bank_branch
    remove_column :users, :bank_name
  end

  def self.down
    add_column :users, :cheque_no, :string
    add_column :users, :bank_branch, :string
    add_column :users, :bank_name, :string
  end
end
