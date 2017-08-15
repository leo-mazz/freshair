class RenameShowBookingField < ActiveRecord::Migration[5.0]
  def change
    rename_column :bookings, :show, :show_id
  end
end
