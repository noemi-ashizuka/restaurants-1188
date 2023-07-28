class Review < ApplicationRecord
  belongs_to :restaurant # creates a method -> review.restaurant
  validates :content, presence: true, length: { minimum: 20 }
end
