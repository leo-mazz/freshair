class CreatePostsTagsTable < ActiveRecord::Migration[5.0]
  def change
    add_index :posts_tags, :post_id
    add_index :posts_tags, :tag_id
  end
end
