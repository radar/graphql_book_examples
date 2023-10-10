require 'rails_helper'

RSpec.describe "Graphql, repo query" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }

  it "retrieves a single repo" do
    query = <<~QUERY
    query ($id: ID!) {
      repo(id: $id) {
        name
        nameReversed
        url
      }
    }
    QUERY

    post "/graphql", params: { query: query, variables: { id: repo.id } }
    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to eq(
      "repo" => {
        "name" => repo.name,
        "nameReversed" => repo.name.reverse,
        "url" => repo.url,
      }
    )
  end
end
