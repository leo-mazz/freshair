class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :body
      t.integer :display_order

      t.timestamps
    end

    create_table :team_members  do |t|
      t.integer :user_id
      t.integer :team_id
      t.boolean :manager
    end

    add_index :team_members, :user_id
    add_index :team_members, :team_id
  end
end
