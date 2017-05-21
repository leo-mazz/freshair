class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.text :description
      t.string :location
      t.string :facebook_event
      t.string :buy_tickets

      t.timestamps
    end
  end
end
