require 'rails_helper'

RSpec.describe "Graphql, repo query" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }

  it "retrieves a single repo" do
    query = <<~QUERY
    query ($id: ID!) {
      repo(id: $id) {
        ...on Repo {
          name
          nameReversed
          url
        }
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

  it "shows an error message when a repo cannot be found" do
    query = <<~QUERY
    query ($id: ID!) {
      repo(id: $id) {
        __typename
        ...on NotFound {
          message
        }
        ...on Repo {
          name
          nameReversed
          url
        }
      }
    }
    QUERY

    post "/graphql", params: { query: query, variables: { id: 'not-an-id' } }
    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to eq(
      "repo" => {
        "__typename" => "NotFound",
        "message" => "Could not find a repository with id='not-an-id'",
      }
    )
  end
end
