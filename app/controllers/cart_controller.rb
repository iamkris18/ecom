class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || Cart.create(user: current_user)
    @cart_items = @cart.cart_items
  end

  def add
    product = Product.find(params[:product_id])
    user=session[:user]
    @cart = current_user.cart || Cart.create(user: current_user)
    
    cart_item = @cart.cart_items.find_by(product_id: product.id)
    if cart_item
      UserActivity.create(user_id: session[:user_id],action: 'item added to cart', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
      cart_item.update(quantity: cart_item.quantity + 1)
      flash[:alert] = "#{product.name} added to cart"
    else
      UserActivity.create(user_id: session[:user_id],action: 'item added to cart', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
      @cart.cart_items.create(product: product, quantity: 1)
      flash[:alert] = "#{product.name} added to cart"
    end
    AbandonedCartEmailJob.set(wait: 10.seconds).perform_later(@cart.id)
    redirect_to products_path
  end
  

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from your cart.'
  end
end
