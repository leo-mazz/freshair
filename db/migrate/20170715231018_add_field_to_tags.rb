class AddFieldToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :is_highlighted, :boolean
  end
end
