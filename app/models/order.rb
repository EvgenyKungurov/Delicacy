class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  scope :order_number_today, -> { where('DATE(created_at) = ?', Time.zone.now).size + 1 }
end
