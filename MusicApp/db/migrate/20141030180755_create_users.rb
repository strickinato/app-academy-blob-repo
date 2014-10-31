class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, uniqueness: true
      t.string :password_digest, null: false
      t.string :session_token, null: false
    end

    add_index :users, :session_token
  end
end
