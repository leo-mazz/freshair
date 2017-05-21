class CreateSubPages < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_pages do |t|
      t.string :title
      t.text :content
      t.belongs_to :page, index: true, unique: true, foreign_key: true
      t.timestamps
    end
  end
end
