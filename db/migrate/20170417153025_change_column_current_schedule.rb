class ChangeColumnCurrentSchedule < ActiveRecord::Migration[5.0]
  def change
    rename_column :schedules, :current, :is_current
  end
end
