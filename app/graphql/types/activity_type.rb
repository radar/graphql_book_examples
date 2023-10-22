module Types
  class ActivityType < Types::BaseObject
    field :event, EventType, null: false
  end
end
