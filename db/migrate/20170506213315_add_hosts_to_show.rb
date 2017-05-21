class AddHostsToShow < ActiveRecord::Migration[5.0]
  def change
    create_table :hosts_shows, id: false do |t|
      t.integer :show_id
      t.integer :host_id
    end

    add_index :hosts_shows, :show_id
    add_index :hosts_shows, :host_id

  end
end
