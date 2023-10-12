module Types
  class CategoryType < Types::BaseObject
    field :name, String, null: false
    field :repos, [RepoType], null: false
  end
end
