class MenuController < ApplicationController
  before_action :set_current_order
  before_action :set_total_price

  def index
    @menu = Category.roots
  end

  def show
    @menu = Category.find(params[:id]).children
  end

  private

  def set_total_price
    @total_price = @current_order.order_items.pluck(:total_price).map.sum.to_s
  end

  def set_current_order
    order = session[:order_id] || session[:order_id] = Order.create.id
    @current_order = Order.includes(:order_items).find(order)
  end
end
