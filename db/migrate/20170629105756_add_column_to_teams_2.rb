class AddColumnToTeams2 < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :hub_show, :integer
  end
end
