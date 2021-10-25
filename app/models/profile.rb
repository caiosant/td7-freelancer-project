class Profile < ApplicationRecord
    belongs_to :freelancer
    has_one_attached :avatar

    validates :full_name, :birth_date, :description, presence: true, on: :update
end
