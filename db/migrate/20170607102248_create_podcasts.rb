class CreatePodcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.string :uri
      t.datetime :broadcast_time
      t.belongs_to :show, index: true, unique: true, foreign_key: true
      t.timestamps
    end
  end
end
