class CreateBooking < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :location
      t.datetime :start
      t.datetime :end
      t.string :slug
      t.integer :user_id

      t.timestamps
    end

    add_index :bookings, :user_id
  end
end
