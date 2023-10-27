require 'rails_helper'

RSpec.describe "Graphql, repo query, with reviews" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }
  before do
    15.times do |i|
      user = User.create!(
        name: "Test User #{i}",
        email: "test#{i}@example.com",
        password: "SecurePassword1"
      )

      repo.reviews.create!(rating: 5, comment: "Review #{i}", user: user)
    end
  end

  it "retrieves all the users for reviews on a repo" do
    query = <<~QUERY
      query ($id: ID!) {
        repo(id: $id) {
          ...on Repo {
            name
            reviews {
              nodes {
                user {
                  name
                }
              }
            }
          }
        }
      }
    QUERY

    post "/graphql", params: { query: query, variables: { id: repo.id } }
    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to match(
      "repo" => a_hash_including(
        "name" => repo.name,
      )
    )

    expect(response.parsed_body.dig("data", "repo", "reviews", "nodes").count).to eq(10)
    users = response.parsed_body.dig("data", "repo", "reviews", "nodes").map { |node| node["user"] }

    expect(users).to be_present
  end
end
