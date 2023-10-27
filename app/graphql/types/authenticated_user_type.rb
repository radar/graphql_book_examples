module Types
  class AuthenticatedUserType < BaseObject
    field :email, String, null: true
    field :token, String, null: true

    def token
      Jot.encode(email: object.email)
    end
  end
end
