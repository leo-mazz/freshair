class RemoveBootsyStuff < ActiveRecord::Migration[5.0]
  def change
    drop_table :bootsy_images
    drop_table :bootsy_image_galleries
  end
end
