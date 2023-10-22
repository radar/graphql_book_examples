module Types
  class ReviewType < Types::BaseObject
    field :id, ID, null: false
    field :rating, ReviewRating, null: false
    field :comment, String, null: false
  end
end
