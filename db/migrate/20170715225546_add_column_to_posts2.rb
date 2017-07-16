class AddColumnToPosts2 < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_highlighted, :boolean
  end
end
