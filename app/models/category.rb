class Category < ApplicationRecord
  include AwesomeNestedSetMethods

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
                            default_url: "/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
  has_many :items
  acts_as_nested_set

  before_save   :name_capitalize
  after_create  :parent_count_increase
  after_destroy :parent_count_decrease
end
