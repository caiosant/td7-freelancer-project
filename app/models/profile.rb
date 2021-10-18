class Profile < ApplicationRecord
    belongs_to :freelancer

    validates :full_name, :birth_date, :description, presence: true, on: :update
end
