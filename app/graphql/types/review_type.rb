module Types
  class ReviewType < Types::BaseObject
    field :rating, Integer, null: false
    field :comment, String, null: false
  end
end
