class CreateFreelancerFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :freelancer_favorites do |t|
      t.references :freelancer, null: false, foreign_key: true
      t.references :project_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
