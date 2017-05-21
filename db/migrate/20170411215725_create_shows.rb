class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.string :title
      t.string :tag_line
      t.text :description
      t.string :slug

      t.timestamps
    end
  end
end
