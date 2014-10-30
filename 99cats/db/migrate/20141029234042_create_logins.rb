class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.integer :user_id, null: false
      t.string :auth_token, null: false
      
      t.timestamps
    end
    add_index :logins, :user_id
    add_index :logins, :auth_token
  end
end
