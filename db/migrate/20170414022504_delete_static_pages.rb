class DeleteStaticPages < ActiveRecord::Migration[5.0]
  def change
    drop_table :static_pages
  end
end
