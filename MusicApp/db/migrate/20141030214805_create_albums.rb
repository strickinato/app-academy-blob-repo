class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.string :recording_type
      t.integer :band_id, null: false
    end
  end
end
