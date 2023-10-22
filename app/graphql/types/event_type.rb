module Types
  class EventType < Types::BaseUnion
    possible_types ReviewType, LikeType

    def self.resolve_type(object, context)
      case object
      when Review
        ReviewType
      when Like
        LikeType
      end
    end
  end
end
