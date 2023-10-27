require 'rails_helper'

RSpec.describe "GraphQL, me query", type: :request do
  let!(:user) do
    User.create!(
      email: "test@example.com",
      password: "SecurePassword1",
      name: "Test User",
    )
  end

  let(:query) do
    <<~QUERY
      query me {
        me {
          email
        }
      }
    QUERY
  end

  it "fetches the current user's information" do
    post "/graphql", params: {
      query: query,
      variables: {
        email: "test@example.com",
        password: "SecurePassword1",
        password_confirmation: "SecurePassword1",
      }
    }, headers: {
      Authorization: "Bearer #{Jot.encode({ email: user.email })}"
    }

    expect(response.parsed_body).not_to have_errors
    me = response.parsed_body["data"]["me"]
    expect(me["email"]).to eq("test@example.com")
  end
end
