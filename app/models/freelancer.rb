class Freelancer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :proposals
  has_many :projects, through: :proposals
  has_many :freelancer_favorites
  has_many :projects_owners, through: :freelancer_favorites
  has_one :profile

  after_create :create_profile

  def create_profile
    Profile.create(freelancer: self)
  end
end
