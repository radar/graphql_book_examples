class Repo < ApplicationRecord
  has_many :categorized_repos
  has_many :categories, through: :categorized_repos
end
