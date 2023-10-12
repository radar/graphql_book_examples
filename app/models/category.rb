class Category < ApplicationRecord
  has_many :categorized_repos
  has_many :repos, through: :categorized_repos
end
