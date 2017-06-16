class OrderItem < ApplicationRecord
  belongs_to :order

  validates :quantity, presence: true,
                       numericality: {
                         only_integer: true, greater_than_or_equal_to: 1
                       }
  validates :order_id, presence: true
  validates :item_id, presence: true

  def item
    Item.find(item_id)
  end
end
