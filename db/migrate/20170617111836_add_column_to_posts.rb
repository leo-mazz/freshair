class AddColumnToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :team_id, :integer
    add_column :posts, :show_id, :integer

    add_index :posts, :team_id
    add_index :posts, :show_id
  end
end
