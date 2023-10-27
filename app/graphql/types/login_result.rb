module Types
  class LoginResult < BaseUnion
    possible_types Types::AuthenticatedUserType, Types::FailedLoginType

    def self.resolve_type(object, context)
      if object.success?
        [Types::AuthenticatedUserType, object.success]
      else
        Types::FailedLoginType
      end
    end
  end
end
