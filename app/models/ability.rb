class Ability < ApplicationRecord
  has_many :project_abilities
  has_many :projects, through: :project_abilities
end
