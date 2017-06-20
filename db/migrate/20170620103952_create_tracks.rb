class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.integer :podcast_id

      t.timestamps
    end
  end
end
