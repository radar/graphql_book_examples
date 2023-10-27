import { GraphQLClient } from "graphql-request";
import { LoginMutationVariables, getSdk } from "./generated/types";

async function login({ email, password }: LoginMutationVariables) {
  const client = new GraphQLClient("http://localhost:3000/graphql");
  const sdk = getSdk(client);

  const query = await sdk.login({ email, password });
  if (query.login.__typename === "AuthenticatedUser") {
    console.log("Successfully signed in");
  } else {
    console.log(query.login.error);
  }
}

login({
  email: "test@example.com",
  password: "SecurePassword1",
})
