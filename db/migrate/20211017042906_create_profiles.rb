class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birth_date
      t.text :description

      t.timestamps
    end
  end
end
