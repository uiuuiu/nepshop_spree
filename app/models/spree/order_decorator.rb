# Customize Step
# http://guides.spreecommerce.org/developer/checkout.html#the-checkout-flow-dsl
Spree::Order.class_eval do
  # remove_checkout_step :address
  # insert_checkout_step :send_message, after: :confirm
end
