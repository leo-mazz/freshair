class AddColumnToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :is_post_type, :boolean
  end
end
