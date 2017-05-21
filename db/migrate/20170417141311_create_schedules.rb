class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :name
      t.boolean :current
      t.date :end_date
      t.references :schedule
      t.timestamps
    end
  end
end
