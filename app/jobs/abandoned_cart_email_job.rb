class AbandonedCartEmailJob < ApplicationJob
  queue_as :default

  def perform(cart_id)
    cart = Cart.find_by(id: cart_id)

    return if cart.nil? || cart.cart_items.empty?

    if cart.cart_items.any?
      UserMailer.with(user: cart.user, cart: cart).abandoned_cart_email.deliver_now
    end
  end
end
