module Mutations
  module Users
    class Login < BaseMutation
      include Dry::Monads[:result]

      type Types::LoginResult, null: false

      argument :email, String, required: true
      argument :password, String, required: true

      def resolve(email:, password:)
        user = User.find_by(email: email)
        if user && user.authenticate(password)
          Success(user)
        else
          Failure()
        end
      end
    end
  end
end
