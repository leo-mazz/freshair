class RenameNextScheduleColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :schedules, :schedule_id, :next_schedule_id
  end
end
