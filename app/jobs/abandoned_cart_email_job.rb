class AbandonedCartEmailJob < ApplicationJob
  queue_as :default

  def perform(cart_id, user_id)
    cart = Cart.find_by(id: cart_id)
    user = User.find_by(id: user_id)
    return if cart.nil? || cart.cart_items.empty? || user.nil?
  
    checkout_pdf = InvoiceGenerator.new(user, cart).generate_pdf
    InvoiceMailer.send_checkout(user, checkout_pdf).deliver_now
  end
end
