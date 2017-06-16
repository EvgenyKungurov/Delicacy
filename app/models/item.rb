class Item < ApplicationRecord
  belongs_to :category

  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
  validates :category_id, presence: true
  validates :price, presence: true
end
