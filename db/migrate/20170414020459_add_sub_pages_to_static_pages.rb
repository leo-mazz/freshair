class AddSubPagesToStaticPages < ActiveRecord::Migration[5.0]
  def change
    add_column :static_pages, :sub_pages, :static_page
  end
end
