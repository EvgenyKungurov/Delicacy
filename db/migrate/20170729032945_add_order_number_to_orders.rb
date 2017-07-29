class AddOrderNumberToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :current_number, :integer, default: 0
  end
end
