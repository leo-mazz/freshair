class RenameHubShow < ActiveRecord::Migration[5.0]
  def change
    rename_column :teams, :hub_show, :hub_show_id
  end
end
