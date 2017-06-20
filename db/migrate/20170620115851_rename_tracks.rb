class RenameTracks < ActiveRecord::Migration[5.0]
  def change
    rename_table :tracks, :played_tracks
  end
end
