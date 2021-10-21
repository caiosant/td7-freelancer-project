class AddProjectToProposalCancelation < ActiveRecord::Migration[6.1]
  def change
    add_reference :proposal_cancelations, :project, null: false, foreign_key: true
  end
end
