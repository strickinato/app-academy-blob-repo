class AddTimeStampsToTrackNotes < ActiveRecord::Migration
  def change
      add_timestamps(:notes)

      rename_column :notes, :note, :track_note
  end
end
