require 'rails_helper'

RSpec.describe "Graphql, addCategory mutation" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }

  it "adds a new category" do
    query = <<~QUERY
    mutation ($name: String!) {
      addCategory(input: { name: $name }) {
        name
      }
    }
    QUERY

    post "/graphql", params: {
      query: query,
      variables: {
        name: "Ruby"
      }
    }

    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to eq(
      "addCategory" => {
        "name" => "Ruby",
      }
    )
  end
end
