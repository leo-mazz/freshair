class CreateTags < ActiveRecord::Migration[5.0]

  def change
    create_table :tags do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :posts_tags do |t|
      t.integer :post_id
      t.integer :tag_id
    end
  end
  
end
