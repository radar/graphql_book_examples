module Mutations
  module Reviews
    class Add < BaseMutation
      type Types::ReviewType, null: false
      graphql_name "AddReview"

      argument :repo_id, ID, required: true
      argument :rating, Types::ReviewRating, required: true
      argument :comment, String, required: true

      def resolve(repo_id:, rating:, comment:)
        Review.create!(
          repo_id: repo_id,
          rating: rating,
          comment: comment,
        )
      end
    end
  end
end
