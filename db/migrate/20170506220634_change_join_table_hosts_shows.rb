class ChangeJoinTableHostsShows < ActiveRecord::Migration[5.0]
  def change
    rename_column :hosts_shows, :host_id, :user_id
  end
end
