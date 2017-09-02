$(document).ready(function(){
  var $available = $('.available'),
      $text_available = $available.children('span');
  var inStock = $available.data('inStock'),
        outStock = $available.data('outStock');
  $('select[name=variant_id]').on('change', function() {
    var $this = $(this),
        is_orderable = $this.find(':selected').data('in-stock'),
        price_stock = $this.find(':selected').data('price'),
        item_image = 'tmb-' + $this.val();

    // Change price
    $('.display-price').text(price_stock);
    if (is_orderable) {
      $('.single-cart').show();
      $text_available.text(inStock);
    }else {
      $('.single-cart').hide();
      $text_available.text(outStock);
    }

    // Change image
    $('#product-thumbnails li').removeClass('selected');
    $('#product-thumbnails').children(' li.' + item_image).addClass('selected').mouseover();
  }).change();
});

