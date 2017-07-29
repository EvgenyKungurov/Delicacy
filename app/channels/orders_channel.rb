class OrdersChannel < ActionCable::Channel::Base
  def subscribed
    stream_for :orders
  end

  # def receive
  #   self.class.broadcast_to :orders, order: render_order
  # end
end
