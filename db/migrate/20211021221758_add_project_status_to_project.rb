class AddProjectStatusToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :project_status, :integer, default: 5
  end
end
