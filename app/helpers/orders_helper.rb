module OrdersHelper
  private

  def current_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    session[:order_id] = Order.create.id
    @order = Order.includes(:order_items).find(session[:order_id])
  end
end
