class AddSubPages < ActiveRecord::Migration[5.0]
  def change
    change_table :static_pages do |t|
      t.belongs_to :static_page, index: true, unique: true, foreign_key: true
    end
  end
end
