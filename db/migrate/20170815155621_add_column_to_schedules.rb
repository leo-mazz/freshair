class AddColumnToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :is_free_schedule, :boolean
  end
end
