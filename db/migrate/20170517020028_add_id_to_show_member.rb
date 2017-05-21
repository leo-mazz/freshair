class AddIdToShowMember < ActiveRecord::Migration[5.0]
  def change
    add_column :show_memberships, :id, :primary_key
  end
end
