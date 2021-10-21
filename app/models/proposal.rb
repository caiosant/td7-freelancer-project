class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer
  has_one :proposal_cancelation

  enum status:{pending: 5, accepted: 10, rejected: 20, canceled: 25}
  

  def can_cancel?
    if status == 'accepted' && (Date.today - updated_at.to_date).to_i > 2
      false
    elsif status == 'accepted' && (Date.today - updated_at.to_date).to_i < 3
      true
    else
      true
    end
  end
end
