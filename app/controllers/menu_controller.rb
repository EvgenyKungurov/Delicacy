class MenuController < ApplicationController
  include OrdersHelper

  before_action :set_current_order_with_total_price

  def index
    @menu = Category.roots
  end

  def show
    @menu = if Category.find(params[:id]).children.size.positive?
              Category.find(params[:id]).children
            else
              [Category.find(params[:id])]
            end
  end

  private

  def set_current_order_with_total_price
    @total_price = current_order.order_items.pluck(:total_price).map.sum.to_s
  end
end
