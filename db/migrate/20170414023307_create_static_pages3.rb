class CreateStaticPages3 < ActiveRecord::Migration[5.0]
  def change
    create_table :static_page do |t|
      t.string :title
      t.text :content
      t.integer :parent_id
    end
    drop_table :categories
  end
end
