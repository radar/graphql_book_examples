module Mutations
  module Reviews
    class Delete < BaseMutation
      type Types::ReviewType
      graphql_name "DeleteReview"

      argument :review_id, ID, required: true

      def resolve(review_id:)
        Review.find(review_id).destroy
      end
    end
  end
end
