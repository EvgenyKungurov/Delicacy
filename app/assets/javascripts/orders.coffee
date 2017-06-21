# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '[id^="item_"]', ->
  item_name  = this.value
  item_id    = this.id.split('_')[1]
  return if $('input[item_id=' + item_id + ']').size() > 0
  $.ajax
    url: "/orders"
    type: "POST" 
    data: order: { item_id: item_id, quantity: 1 }
    success: (response, total_price) ->
      $('#sidebar').append('<div class="bordered" id=order_item_' + response['order_item'].id + '_block>')
      $('#order_item_' + response['order_item'].id + '_block').append(
        '<p id=order_item_' + response['order_item'].id + '>' + item_name + '</p>
        <div class=row><div class="column col-xs-6">
        <input type=number class=form-control min=1 id=order_item_' + response['order_item'].id + '_quantity value=' + response['order_item'].quantity + ' item_id=' + item_id + '></div>
        <div class="column col-xs-2"><button name=button class="btn btn-warning" type=submit id=order_otem_' + response['order_item'].id + '_remove>Удалить</button></div></div>')
      $('#total_price').text('Итого: ' + response['order_total_price'] + ' рублей')

$(document).on 'change', '[id$="_quantity"]', ->
  quantity = this.value
  order_item_id  = this.id.split('_')[2]
  $.ajax
    url: '/order_items/' + order_item_id
    type: "PATCH" 
    data: order: { quantity: quantity }
    success: (response, total_price) ->
      $('#order_item_' + response['order_item'].id + '_quantity').val(response['order_item'].quantity).attr('value', response['order_item'].quantity)
      $('#total_price').text('Итого: ' + response['order_total_price'] + ' рублей')

$(document).on 'click', '[id$="_remove"]', ->
  order_item_id = this.id.split('_')[2]
  $.ajax
    url: '/order_items/' + order_item_id
    type: "DELETE" 
    data: order: { id: order_item_id }
    success: (response) ->
      $('#order_item_' + order_item_id + '_block').remove()
      $('#total_price').text('Итого: ' + response.order_total_price + ' рублей')

$(document).on 'click', '[id="print_order"]', ->
  $.ajax
    url: '/orders/new/'
    success: (response) ->
      window.location.reload()

