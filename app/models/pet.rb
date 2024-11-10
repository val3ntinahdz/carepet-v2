class Pet < ApplicationRecord
  belongs_to :user
  has_many :conditions, dependent: :destroy
  has_many :diseases, through: :conditions
  has_many :appointments, dependent: :destroy
  has_many :services, through: :appointments
  has_many :trainings
  has_many :nutritions, dependent: :destroy
  has_many :allergies, dependent: :destroy
  has_many :allergens, through: :allergies
  has_many :veterinaries, through: :services
  has_many :vaccinations, dependent: :destroy
  has_many :vaccines, through: :vaccinations
  has_one_attached :photo
end
