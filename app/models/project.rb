class Project < ApplicationRecord
    belongs_to :project_owner

    validates :title, :description, :max_value, :deadline, :location, presence: true
    validates :description, length: { minimum: 30 }
    validates :max_value, numericality: {greater_than: 0} 
    validate :deadline_is_possible?
    
    
    def deadline_is_possible?
        return if deadline.blank?
        if Date.today() > deadline
            errors.add(:deadline, 'precisa maior ou igual a hoje')
        end
    end
end
