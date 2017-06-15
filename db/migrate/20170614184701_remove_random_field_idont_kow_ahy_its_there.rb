class RemoveRandomFieldIdontKowAhyItsThere < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :slug
  end
end
