class OrdersController < ApplicationController
  before_action :set_order

  def create
    order_item = @order.order_items.build(order_params)

    respond_to do |format|
      if order_item.save
        format.json { render json: order_item }
      else
        format.json { render json: order_item.errors }
      end
    end
  end

  private

  def set_order
    return @order = Order.find(session[:order_id]) if session[:order_id]
    session[:order_id] = Order.create.id
    @order = Order.find(session[:order_id])
  end

  def order_params
    params.require(:order).permit(:item_id, :quantity)
  end
end
