class CategorizedRepo < ApplicationRecord
  belongs_to :category
  belongs_to :repo
end
