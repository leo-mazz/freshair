class RemodelSchedules < ActiveRecord::Migration[5.0]
  def change
    remove_column :schedules, :is_current
    remove_column :schedules, :next_schedule_id
    add_column :schedules, :start_date, :date
  end
end
