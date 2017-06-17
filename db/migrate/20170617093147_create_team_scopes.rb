class CreateTeamScopes < ActiveRecord::Migration[5.0]
  def change
    create_table :team_scopes do |t|
      t.integer :team_id
      t.integer :post_id

      t.timestamps
    end

    add_index :team_scopes, :team_id
    add_index :team_scopes, :post_id
  end
end
