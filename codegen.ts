import type { CodegenConfig } from '@graphql-codegen/cli';

const config: CodegenConfig = {
  overwrite: true,
  schema: "http://localhost:3000/graphql",
  documents: 'app/javascript/graphql/**/*.graphql',
  generates: {
    "app/javascript/graphql/generated/types.ts": {
      plugins: ['typescript', 'typescript-operations', 'typescript-graphql-request']
    }
  },
};

export default config;
