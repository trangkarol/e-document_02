class Category < ApplicationRecord
  has_many :documents, dependent: :destroy
end
