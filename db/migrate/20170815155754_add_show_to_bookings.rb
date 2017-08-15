class AddShowToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :show, :integer
  end
end
