class Project < ApplicationRecord
    belongs_to :project_owner
    has_many :project_abilities
    has_many :abilities, through: :project_abilities

    validates :title, :description, :max_value, :deadline, :location, presence: true
    validates :description, length: { minimum: 30 }
    validates :max_value, numericality: {greater_than: 0} 
    validate :deadline_is_possible?
    validate :has_ability?
    
    
    def deadline_is_possible?
        return if deadline.blank?
        if Date.current() > deadline
            errors.add(:deadline, 'precisa maior ou igual a hoje')
        end
    end

    def has_ability?
        if abilities.blank?
            errors.add(:abilities, 'precisa ter ao mínimo uma opção selecionada')
        end
    end
end
