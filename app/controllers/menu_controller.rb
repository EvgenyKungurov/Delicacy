class MenuController < ApplicationController
  def index
    @menu = Category.all
    @current_order = Order.includes(:order_items).find(current_order)
  end

  private

  def current_order
    session[:order_id] || session[:order_id] = Order.create.id
  end
end
