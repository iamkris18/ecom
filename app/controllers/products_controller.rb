class ProductsController < ApplicationController

    def index
      @products = Product.all
      @cart_items = current_user.cart.cart_items.includes(:product) if current_user&.cart

    end

    def show

        @product = Product.find(params[:id])

    end

end
