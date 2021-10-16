class CreateProjectAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :project_abilities do |t|
      t.references :ability, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
