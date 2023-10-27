require 'rails_helper'

RSpec.describe "GraphQL, signUp mutation", type: :request do
  let(:query) do
    <<~QUERY
      mutation signup(
        $email: String!,
        $password: String!,
        $password_confirmation: String!,
        $name: String!) {
        signup(
          input: {
            email: $email,
            password: $password,
            passwordConfirmation: $password_confirmation,
            name: $name,
          }
        ) {
        ...on AuthenticatedUser {
          email
          token
        }
        ...on ValidationError {
          errors {
            fullMessages
            attributeErrors {
              attribute
              errors
            }
          }
        }
      }
    }
    QUERY
  end

  it "signs up a new user successfully" do
    post "/graphql", params: {
      query: query,
      variables: {
        email: "test@example.com",
        password: "SecurePassword1",
        password_confirmation: "SecurePassword1",
        name: "Test User",
      }
    }

    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to match(
      "signup" => {
        "email" => "test@example.com",
        "token" => be_present
      }
    )

    expect(response.parsed_body["data"]["signup"]["token"]).to be_present
  end

  it "cannot sign up with a missing email" do
    post "/graphql", params: {
      query: query,
      variables: {
        name: "Test User",
        email: "",
        password: "SecurePassword1",
        password_confirmation: "SecurePassword1",
      }
    }

    expect(response.parsed_body).not_to have_errors
    signup = response.parsed_body["data"]["signup"]
    expect(signup).to eq(
      "errors" => {
        "fullMessages" => ["Email can't be blank"],
        "attributeErrors" => [
          {
            "attribute" => "email",
            "errors" => ["can't be blank"],
          }
        ]
      }
    )
  end
end
