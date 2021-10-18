class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.text :application_reason
      t.decimal :hour_value
      t.integer :hours
      t.date :deadline_proposal
      t.references :project, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
