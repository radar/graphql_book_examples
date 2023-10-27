module Types
  class SignupResult < BaseUnion
    possible_types Types::AuthenticatedUserType, Types::ValidationErrorType

    def self.resolve_type(object, _context)
      if object.success?
        [Types::AuthenticatedUserType, object.success]
      else
        [Types::ValidationErrorType, object.failure]
      end
    end
  end
end
