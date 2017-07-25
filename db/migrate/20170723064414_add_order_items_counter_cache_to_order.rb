class AddOrderItemsCounterCacheToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_items_count, :integer, default: 0
  end
end
