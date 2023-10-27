require 'rails_helper'

RSpec.describe "GraphQL, updateReview mutation" do
  let!(:repo) { Repo.create!(name: "Repo Hero", url: "https://github.com/repohero/repohero") }
  let!(:user) do
    User.create!(
      email: "test@example.com",
      password: "SecurePassword1",
      name: "Test User",
    )
  end
  let!(:review) do
    repo.reviews.create!(
      comment: "Kind of good",
      rating: 3,
      user: user
    )
  end

  it "edits an existing review" do
    query = <<~QUERY
    mutation ($id: ID!, $rating: String!, $comment: String!) {
      updateReview(input: { reviewId: $id, rating: $rating, comment: $comment }) {
        rating
        comment
      }
    }
    QUERY

    post "/graphql", params: {
      query: query,
      variables: {
        id: repo.id,
        rating: 5,
        comment: "On further thought, amazing!"
      }
    }

    expect(response.parsed_body).not_to have_errors
    expect(response.parsed_body["data"]).to eq(
      "updateReview" => {
        "rating" => "FIVE_STARS",
        "comment" => "On further thought, amazing!"
      }
    )
  end
end
