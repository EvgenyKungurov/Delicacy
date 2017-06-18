class OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if order_item.update(order_item_params)
        format.json { render json: order_item }
      else
        format.json { render json: order_item.errors }
      end
    end
  end

  private

  def order_item_params
    params.require(:order).permit(:quantity)
  end
end
