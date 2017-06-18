class OrderItemsController < ApplicationController
  before_action :set_order

  def update
    order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if order_item.update(order_item_params)
        format.json { render json: { order_item: order_item, order_total_price: @order.order_items.pluck(:total_price).sum } }
      else
        format.json { render json: order_item.errors }
      end
    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if order_item.destroy
        format.json { render json: { order_total_price: @order.order_items.pluck(:total_price).sum } }
      else
        format.json { render json: order_item.errors }
      end
    end
  end

  private

  def order_item_params
    params.require(:order).permit(:quantity)
  end

  def set_order
    return @order = Order.find(session[:order_id]) if session[:order_id]
    session[:order_id] = Order.create.id
    @order = Order.find(session[:order_id])
  end
end
