module Types
  class FailedLoginType < BaseObject
    field :error, String, null: false

    def error
      "Invalid email or password"
    end
  end
end
