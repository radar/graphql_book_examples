module Types
  class LikeType < Types::BaseObject
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
