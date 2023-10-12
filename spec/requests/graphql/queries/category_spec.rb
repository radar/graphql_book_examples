require 'rails_helper'

RSpec.describe "Graphql, category query" do
  let!(:category) { Category.create!(name: "Ruby") }
  let!(:repo) do
    Repo.create!(
      name: "Repo Hero",
      url: "https://github.com/repohero/repohero",
      categories: [category]
    )
  end

  it "retrieves a single category" do
    query = <<~QUERY
    query ($id: ID!) {
      category(id: $id) {
        name
        repos {
          name
          url
        }
      }
    }
    QUERY

    post "/graphql", params: { query: query, variables: { id: category.id } }
    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to eq(
      "category" => {
        "name" => category.name,
        "repos" => [
          {
            "name" => repo.name,
            "url" => repo.url,
          }
        ]
      }
    )
  end
end
