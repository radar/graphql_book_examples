module GraphqlRequests
  def graphql_request(query:, variables: {}, user: nil)
     request_arguments = {
      params: {
        query: query,
        variables: variables,
      }
    }
    if user
      request_arguments.merge!(
        headers: {
          Authorization: "Bearer #{Jot.encode({ email: user.email })}"
        }
      )
    end

    post "/graphql", **request_arguments
  end
end

RSpec.configure do |config|
  config.include GraphqlRequests, type: :request
end
