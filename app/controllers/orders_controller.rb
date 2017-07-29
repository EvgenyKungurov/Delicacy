class OrdersController < ApplicationController
  include OrdersHelper

  before_action :current_order

  def create
    order_item = @order.order_items.build(order_params)

    respond_to do |format|
      if order_item.save
        response = { order_item: order_item, order_total_price: total_price }
        format.json { render json: response }
      else
        format.json { render json: order_item.errors }
      end
    end
  end

  def new
    order_status(params[:order][:status])
    delete_order_from_cookie
    send_notify_to_kitchen
    respond_to do |format|
      if session[:order_id].nil?
        format.json { render json: { status: 'Созднан новый заказ' } }
      else
        format.json { render json: { status: 'Ошибка создания заказа' } }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:item_id, :quantity)
          .merge(total_price: Item.find(params[:order][:item_id]).price)
  end
end
