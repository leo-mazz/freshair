class RenameMetaData < ActiveRecord::Migration[5.0]
  def change
    rename_table :post_meta_data, :post_metadata
  end
end
