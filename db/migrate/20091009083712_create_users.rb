class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :name,                      :string, :limit => 50
      t.column :email,                     :string, :limit => 50
      t.column :dob,                       :date
      t.column :phone,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :cheque_no,                 :string
      t.column :bank_name,                 :string
      t.column :bank_branch,               :string
      t.column :identification_token,      :string
      t.column :activation_token,          :string
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime


    end
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
