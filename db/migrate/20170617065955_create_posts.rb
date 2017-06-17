class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :short_body
      t.text :content
      t.integer :author
      t.boolean :is_published
      t.integer :scope

      t.timestamps
    end
  end
end
