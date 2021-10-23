class FreelancerFavorite < ApplicationRecord
  belongs_to :freelancer
  belongs_to :project_owner

  validates :freelancer_id, uniqueness: {scope: :project_owner_id}
end
