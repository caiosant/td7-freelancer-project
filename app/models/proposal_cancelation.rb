class ProposalCancelation < ApplicationRecord
  belongs_to :proposal
  
  validates :reason, presence: true
  validates :reason, length: { minimum: 30 }
end
