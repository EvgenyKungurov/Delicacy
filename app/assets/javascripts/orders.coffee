# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '[id^="item_"]', ->
  item_name = this.value
  item_id   = this.id.split('_')[1]
  $.ajax
    url: "/orders"
    type: "POST" 
    data: order: { item_id: item_id, quantity: 1 }
    success: (response) ->
      $('#sidebar').append('<p id=order_item_' + item_id + '>' + item_name + '</p>')
