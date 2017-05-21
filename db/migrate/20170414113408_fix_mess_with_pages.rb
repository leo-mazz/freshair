class FixMessWithPages < ActiveRecord::Migration[5.0]
  def change
    drop_table :static_pages
    create_table :pages do |t|
      t.string :title
      t.text :content
    end
  end
end
