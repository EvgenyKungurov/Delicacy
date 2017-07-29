App.orders = App.cable.subscriptions.create { channel: "OrdersChannel" },
  received: (data) ->
    $('#order_panel').append(data['order'])