class AddPriorityToPage < ActiveRecord::Migration[5.0]
  def change
    add_column :sub_pages, :priority, :integer
    add_column :pages, :priority, :integer
  end
end
