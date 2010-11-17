class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :login

      t.database_authenticatable :null => false 
      t.recoverable
      t.rememberable
      t.trackable

      t.string :ref_code, :null => false
      t.boolean :is_admin, :default => false
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :login,                :unique => true
    add_index :users, :ref_code,             :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
