class AddSlugsToPages < ActiveRecord::Migration[5.0]
  def change
    change_table :sub_pages do |t|
      t.string :slug
    end
    change_table :pages do |t|
      t.string :slug
    end
  end
end
