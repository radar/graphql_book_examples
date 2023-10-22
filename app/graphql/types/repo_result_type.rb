module Types
  class RepoResultType < Types::BaseUnion
    possible_types RepoType, NotFoundType

    def self.resolve_type(object, context)
      if object.is_a?(Repo)
        RepoType
      else
        NotFoundType
      end
    end
  end
end
