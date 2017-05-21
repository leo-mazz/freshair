class CreateScheduleAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_assignments do |t|
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time
      t.belongs_to :schedule, index: true
      t.belongs_to :show, index: true
      t.timestamps
    end
  end
end
