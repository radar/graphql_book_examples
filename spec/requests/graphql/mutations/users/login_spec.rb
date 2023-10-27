require 'rails_helper'

RSpec.describe "GraphQL, login mutation", type: :request do
  let(:user) do
    User.create!(
      email: "test@example.com",
      password: "SecurePassword1",
      name: "Test User",
    )
  end

  let(:query) do
    <<~QUERY
    mutation login($email: String!, $password: String!) {
      login(
        input: {
          email: $email,
          password: $password,
        }
      ) {
        __typename
        ...on AuthenticatedUser {
          email
          token
        }
        ...on FailedLogin {
          error
        }
      }
    }
    QUERY
  end

  it "logs in successfully" do
    post "/graphql", params: {
      query: query,
      variables: {
        email: user.email,
        password: "SecurePassword1",
      }
    }

    expect(response.parsed_body).not_to have_errors
    login = response.parsed_body["data"]["login"]
    expect(login["__typename"]).to eq("AuthenticatedUser")
    expect(login["email"]).to eq("test@example.com")
    expect(login["token"]).to be_present
  end

  it "cannot log in with an invalid password" do
    post "/graphql", params: {
      query: query,
      variables: {
        email: user.email,
        password: "password",
      }
    }

    expect(response.parsed_body).not_to have_errors
    login = response.parsed_body["data"]["login"]
    expect(login["__typename"]).to eq("FailedLogin")
  end
end
