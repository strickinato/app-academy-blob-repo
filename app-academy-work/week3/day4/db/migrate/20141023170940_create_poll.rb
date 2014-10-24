class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :author_id
      t.string :title
      
      t.timestamps
    end
    
    add_index :polls, :author_id
    add_index :polls, :title, unique: true
  end
end
