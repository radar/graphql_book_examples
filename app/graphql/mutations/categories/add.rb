module Mutations
  module Categories
    class Add < BaseMutation
      type Types::CategoryType, null: false
      graphql_name "AddCategory"

      argument :name, String, required: true

      def resolve(name:)
        Category.create!(name: name)
      end
    end
  end
end
