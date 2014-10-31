class AddLyricSupportToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :lyrics, :text
    add_column :tracks, :ord, :integer
    change_column :tracks, :ord, :integer, :default => 0, :null => false
  end
end
