class Item < ApplicationRecord
  belongs_to :category
  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
end
