class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer
  has_one :proposal_cancelation

  enum proposal_status:{pending: 5, accepted: 10, rejected: 20, canceled: 25}
  

  def can_cancel?
    if proposal_status == 'accepted' && (Date.today - updated_at.to_date).to_i > 2
      false
    elsif proposal_status == 'accepted' && (Date.today - updated_at.to_date).to_i < 3
      true
    else
      true
    end
  end
end
