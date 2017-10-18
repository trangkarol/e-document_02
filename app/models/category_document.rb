class CategoryDocument < ApplicationRecord
  belongs_to :category
  belongs_to :document
end
