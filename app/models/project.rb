class Project < ApplicationRecord
  belongs_to :project_owner
  has_many :proposals
  has_many :project_abilities
  has_many :abilities, through: :project_abilities
  has_many :project_cancelations, through: :proposal
  has_many :freelancer_feedbacks
  has_many :freelancers, through: :freelancer_feedbacks

  validates :title, :description, :max_value, :deadline, :location, presence: true
  validates :description, length: { minimum: 30 }
  validates :max_value, numericality: { greater_than: 0 }
  validate :deadline_is_possible?
  validate :has_ability?

  enum location: { remotely: 5, local: 10 }
  enum project_application: { open: 5, closed: 10 }
  enum project_status: { started: 5, finished: 10 }

  def deadline_is_possible?
    return if deadline.blank?

    errors.add(:deadline, 'precisa maior ou igual a hoje') if Date.current > deadline
  end

  def self.my_project?(project, project_owner)
    return false if project_owner.blank?

    project.project_owner_id == project_owner.id
  end

  def has_ability?
    errors.add(:abilities, 'precisa ter ao mínimo uma opção selecionada') if abilities.blank?
  end

  def self.location_attributes_for_select
    locations.map do |location, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.locations.#{location}"), location]
    end
  end
end
