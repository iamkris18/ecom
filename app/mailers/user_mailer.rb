class UserMailer < ApplicationMailer
    def abandoned_cart_email
        @user = params[:user]  
        @cart = params[:cart]  
        if @user.present? && @user.email.present?
          @cart_items = @user.cart.cart_items
          mail(to: @user.email, subject: 'You left items in your cart!')
        else
          Rails.logger.error "User email is missing for user: #{@user.id}" if @user.present?
        end
      end
      
  end
  