class ProjectOwner < ApplicationRecord
  has_many :projects
  has_many :freelancer_favorites
  has_many :freelancers, through: :freelancer_favorites

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
