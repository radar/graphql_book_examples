class Activity < ApplicationRecord
  belongs_to :repo
  belongs_to :event, polymorphic: true
end
