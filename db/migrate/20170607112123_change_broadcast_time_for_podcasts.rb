class ChangeBroadcastTimeForPodcasts < ActiveRecord::Migration[5.0]
  def change
    remove_column :podcasts, :broadcast_time
    add_column :podcasts, :broadcast_date, :date
  end
end
