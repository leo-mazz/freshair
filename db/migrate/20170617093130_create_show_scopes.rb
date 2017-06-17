class CreateShowScopes < ActiveRecord::Migration[5.0]
  def change
    create_table :show_scopes do |t|
      t.integer :show_id
      t.integer :post_id

      t.timestamps
    end

    add_index :show_scopes, :show_id
    add_index :show_scopes, :post_id
  end
end
