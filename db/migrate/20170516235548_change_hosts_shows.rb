class ChangeHostsShows < ActiveRecord::Migration[5.0]
  def change
    rename_table :hosts_shows, :show_members
  end
end
