class AddDeviceIdentifiers < ActiveRecord::Migration
  def change
    add_column :logins, :remote_address, :string, null: false
    add_column :logins, :user_agent, :string, null: false
  end
  
  
end
