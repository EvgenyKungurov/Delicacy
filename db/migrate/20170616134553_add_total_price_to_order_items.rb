class AddTotalPriceToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :total_price, :decimal, precision: 8, scale: 2
  end
end
