class Order < ApplicationRecord
  before_save :set_current_order_number

  has_many :order_items, dependent: :destroy

  scope :order_number_today, -> { where('DATE(created_at) = ?', Time.zone.now).size }

  VALID_STATES = [
    COOKING = 1,
    COOKED  = 2,
    SENDED  = 3
  ].freeze

  private

  def set_current_order_number
    return if current_number.positive?
    self.current_number = Order.order_number_today + 1
  end
end
