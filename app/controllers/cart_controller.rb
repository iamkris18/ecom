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
      UserActivity.create(user_id: session[:user_id],action: "#{product.name} added to cart", performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
      cart_item.update(quantity: cart_item.quantity + 1)
      flash[:alert] = "#{product.name} added to cart"
    else
      UserActivity.create(user_id: session[:user_id],action: "#{product.name} added to cart", performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
      @cart.cart_items.create(product: product, quantity: 1)
      flash[:alert] = "#{product.name} added to cart"
    end
    AbandonedCartEmailJob.set(wait: 10.seconds).perform_later(@cart.id)
    redirect_to products_path
  end
  

  def remove
    @cart_item = CartItem.find_by(id: params[:id])
    product = Product.find(@cart_item.product_id)
    if @cart_item
      if @cart_item.quantity > 1
        @cart_item.update(quantity: @cart_item.quantity - 1)
        flash[:notice] = 'One quantity removed from your cart.'
      else
        @cart_item.destroy
        flash[:notice] = 'Item removed from your cart.'
      end
      UserActivity.create(user_id: session[:user_id],action: "#{product.name} removed from the cart",performed_at: Time.current,metadata: { ip_address: request.remote_ip, device: 'desktop' })
    else
      flash[:alert] = 'Item not found in your cart.'
    end
    redirect_to cart_path
  end
  
  
end
