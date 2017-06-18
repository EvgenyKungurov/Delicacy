class OrderItem < ApplicationRecord
  before_save :sum_price

  belongs_to :order

  validates :quantity, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 1
  }

  validates :total_price, presence: true

  validates :order_id, presence: true
  validates :item_id, presence: true

  def item
    Item.find(item_id)
  end

  private

  def sum_price
    self.total_price = quantity * Item.find(item_id).price
  end
end
