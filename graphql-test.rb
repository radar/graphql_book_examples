operation = <<~GQL
query {
  testField
}
GQL

result = RepoHeroSchema.execute(operation)
puts JSON.pretty_generate(result)
