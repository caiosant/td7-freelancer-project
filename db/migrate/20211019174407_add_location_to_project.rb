class AddLocationToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :location, :integer
  end
end
