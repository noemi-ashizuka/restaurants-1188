class Restaurant < ApplicationRecord
  # associations -> has_many / belongs_to
  has_many :reviews, dependent: :destroy # creates a method -> restaurant.reviews
  belongs_to :user
  # dependent destroy -> will delete the reviews along with the restaurant
  # validations
  # validates :column_name, validation_name: arg
  validates :name, presence: true
  validates :address, presence: true
end
