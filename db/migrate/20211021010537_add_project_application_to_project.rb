class AddProjectApplicationToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :project_application, :integer, default: 5
  end
end
