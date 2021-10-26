class FreelancerFeedback < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer

  validates :grade, :coment, presence: true
  validates :coment, length: { minimum: 30 }
  validates :grade, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5} 
  validates :freelancer_id, uniqueness: {scope: :project_id}
end
