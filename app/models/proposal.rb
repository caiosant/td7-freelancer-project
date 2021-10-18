class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer

  enum status:{pending: 5, accepted: 10, rejected: 20, canceled: 25}
  
end
