class OrdersPanelController < ApplicationController
  include OrdersHelper

  def index
    @orders = OrderSearcher.new(orders_params).call
  end

  private

  def orders_params
    orders_today_with_status(params[:status])
  end
end
