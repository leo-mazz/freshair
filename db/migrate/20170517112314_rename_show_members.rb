class RenameShowMembers < ActiveRecord::Migration[5.0]
  def change
    rename_table :show_members, :show_memberships
  end
end
