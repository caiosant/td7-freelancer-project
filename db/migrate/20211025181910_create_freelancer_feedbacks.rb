class CreateFreelancerFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :freelancer_feedbacks do |t|
      t.integer :grade
      t.text :coment
      t.references :project, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
