class GetRidOfS < ActiveRecord::Migration[5.0]
  def change
    drop_table :static_page
    create_table :static_pages do |t|
      t.string :title
      t.text :content
    end
  end
end
