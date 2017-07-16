class AddPicToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :pic, :string
  end
end
