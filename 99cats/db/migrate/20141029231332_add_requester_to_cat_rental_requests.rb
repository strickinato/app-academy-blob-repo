class AddRequesterToCatRentalRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, null: false, default: 12
    add_index :cat_rental_requests, :user_id
  end
end
