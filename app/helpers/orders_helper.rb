module OrdersHelper
  private

  def delete_order_from_cookie
    session[:order_id] = nil
  end

  def orders_today_positive?
    params = {
      start_date: Time.zone.now.to_date.beginning_of_day,
      end_date: Time.zone.now.to_date.end_of_date
    }
    OrderSearcher.new(params).call.size.positive?
  end

  def orders_today_with_status(status)
    { start_date: Time.zone.now.to_date.beginning_of_day,
      end_date: Time.zone.now.to_date.end_of_day,
      status: status }
  end

  def total_price
    @order.order_items.pluck(:total_price).sum.to_s
  end

  def current_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    session[:order_id] = Order.create.id
    @order = Order.includes(:order_items).find(session[:order_id])
  end

  def order_status(status)
    @order.update_attributes!(status: status)
  end

  def send_notify_to_kitchen
    OrdersChannel.broadcast_to :orders, order: render_order(@order)
  end

  def render_order(order)
    OrdersPanelController.render partial: 'orders_panel/order',
                                 locals: { order: order }
  end
end
