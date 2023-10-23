class Review < ApplicationRecord
  belongs_to :repo

  validates :rating, presence: true, numericality: { between: 1..5 }
  validates :comment, presence: true
end
