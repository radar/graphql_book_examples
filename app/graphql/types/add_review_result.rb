module Types
  class AddReviewResult < Types::BaseUnion
    possible_types Types::ReviewType, Types::ValidationErrorType

    def self.resolve_type(object, context)
      if object.success?
        [Types::ReviewType, object.success]
      else
        [Types::ValidationErrorType, object.failure]
      end
    end
  end
end
