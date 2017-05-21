class AddPicToShows < ActiveRecord::Migration[5.0]
  def change
    add_column :shows, :pic, :string
  end
end
