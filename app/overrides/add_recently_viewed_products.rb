Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_recently_viewed_products_to_products_show',
  insert_after: ".single-p-tab-content",
  partial: 'spree/shared/add_recently_viewed_products'
)

Deface::Override.new(
  virtual_path: 'spree/products/index',
  name: 'add_recently_viewed_products_to_products_index',
  insert_after: ".product-content",
  partial: 'spree/shared/add_recently_viewed_products'
)
