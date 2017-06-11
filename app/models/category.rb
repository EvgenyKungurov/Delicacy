class Category < ApplicationRecord
  include AwesomeNestedSetMethods

  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
  has_many :items
  acts_as_nested_set

  before_save   :name_capitalize
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease
end
