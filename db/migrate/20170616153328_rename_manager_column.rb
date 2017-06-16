class RenameManagerColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :team_memberships, :manager, :is_manager
  end
end
