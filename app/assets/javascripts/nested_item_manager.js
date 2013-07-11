$(document).on('click', '.js-remove-nested-item', function(e){
  e.preventDefault();
  var controlGroup = $(this).closest('.control-group');
  $(controlGroup).remove();
});

$(document).on('click', '.js-add-nested-item', function(e){
  e.preventDefault();
  var content = $(this).data('content');
  var association = $(this).data('association');
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  var pos = $(this).closest('.nested-item-block');
  $(pos).append(content.replace(regexp, new_id));
});