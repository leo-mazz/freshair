class RemoveTeamScopes < ActiveRecord::Migration[5.0]
  def change
    drop_table :team_scopes
    drop_table :show_scopes
  end
end
