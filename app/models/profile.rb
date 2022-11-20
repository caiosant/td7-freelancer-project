class Profile < ApplicationRecord
  belongs_to :freelancer
  belongs_to :occupation_area, optional: true
  has_one_attached :avatar

  validates :full_name, :birth_date, :description, :occupation_area, presence: true, on: :update
end
