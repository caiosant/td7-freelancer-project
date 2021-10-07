class AddAttributesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :social_name, :string
    add_column :users, :birth_date, :string
    add_column :users, :graduate, :string
    add_column :users, :description, :text
  end
end
