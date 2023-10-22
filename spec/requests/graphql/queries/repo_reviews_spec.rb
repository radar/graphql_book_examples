require 'rails_helper'

RSpec.describe "Graphql, repo query, with reviews" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }
  before do
    15.times do |i|
      repo.reviews.create!(rating: 5, comment: "Review #{i}")
    end
  end

  it "retrieves a single repo, with two pages of reviews" do
    query = <<~QUERY
    query ($id: ID!, $after: String) {
      repo(id: $id) {
        ...on Repo {
          name
          reviews(after: $after) {
            nodes {
              rating
              comment
            }
            pageInfo {
              endCursor
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
    end_cursor = response.parsed_body.dig("data", "repo", "reviews", "pageInfo", "endCursor")

    post "/graphql", params: { query: query, variables: { id: repo.id, after: end_cursor } }
    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to match(
      "repo" => a_hash_including(
        "name" => repo.name,
      )
    )

    expect(response.parsed_body.dig("data", "repo", "reviews", "nodes").count).to eq(5)
  end
end
