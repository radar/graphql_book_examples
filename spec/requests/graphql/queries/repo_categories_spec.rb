require 'rails_helper'

RSpec.describe "Graphql, repo query, with categories" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }
  let!(:category) { Category.create!(name: "Ruby") }

  before do
    repo.categories << category
  end

  it "retrieves a single repo, with its categories" do
    query = <<~QUERY
    query findRepoCategories($id: ID!) {
      repo(id: $id) {
        name
        categories {
          name
        }
      }
    }
    QUERY

    post "/graphql", params: { query: query, variables: { id: repo.id } }
    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to eq(
      "repo" => {
        "name" => repo.name,
        "categories" => [
          {
            "name" => category.name,
          }
        ]
      }
    )
  end
end
