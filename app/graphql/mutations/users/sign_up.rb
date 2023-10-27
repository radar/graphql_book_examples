module Mutations
  module Users
    class SignUp < BaseMutation
      include Dry::Monads[:result]
      type Types::SignupResult, null: false

      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      def resolve(name:, email:, password:, password_confirmation:)
        user = User.new(
          name: name,
          email: email,
          password: password,
          password_confirmation: password_confirmation
        )

        if user.save
          Success(user)
        else
          Failure(user)
        end
      end
    end
  end
end
