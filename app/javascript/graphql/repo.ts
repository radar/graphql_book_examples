import { GraphQLClient } from "graphql-request"
import { RepositoryQueryVariables, getSdk } from "./generated/types"

async function getRepo(id: RepositoryQueryVariables["id"]) {
  const client = new GraphQLClient('http://localhost:3000/graphql')
  const sdk = getSdk(client)

  const query = await sdk.repository({ id });
  if (query.repo.__typename === "Repo") {
    console.log(query.repo.name)
  } else {
    console.log(query.repo.message)
  }
}

getRepo("1")
