module Types
  class MutationType < Types::BaseObject
    field :add_review, mutation: Mutations::Reviews::Add
    field :update_review, mutation: Mutations::Reviews::Update
    field :delete_review, mutation: Mutations::Reviews::Delete

    field :add_category, mutation: Mutations::Categories::Add
  end
end
