class AddSolvedToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :solved, :boolean
  end
end
