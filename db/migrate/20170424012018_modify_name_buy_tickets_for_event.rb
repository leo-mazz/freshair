class ModifyNameBuyTicketsForEvent < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :buy_tickets, :link_to_tickets
  end
end
