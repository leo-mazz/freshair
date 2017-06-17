class CreatePostMetaData < ActiveRecord::Migration[5.0]
  def change
    create_table :post_meta_data do |t|
      t.string :key
      t.string :value
      t.integer :post_id

      t.timestamps
    end

    add_index :post_meta_data, :post_id
  end
end
