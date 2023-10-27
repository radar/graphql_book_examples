import { GraphQLClient } from "graphql-request";
import { getSdk } from "./generated/types";

async function getRepos() {
  const client = new GraphQLClient('http://localhost:3000/graphql')
  const sdk = getSdk(client)

  const repos = await sdk.repositories();
  for (const repo of repos.repos) {
    console.log(repo.name)
  }
}

getRepos();
