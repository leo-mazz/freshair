class RemoveColumnFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :scope, :string
  end
end
