class UsersController < ApplicationController
    before_action :require_login
  
    def profile
      @user = current_user
      @cart_items = @user.cart.cart_items.includes(:product) if @user.cart
    end
  
    def update
        @user = current_user
        if @user.update(user_params)
          user.user_activities.create(action: 'updated profile', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
          redirect_to profile_path, notice: 'Profile updated successfully!'
        else
          flash[:alert] = 'Error updating profile.'
          render :profile
        end
      end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :profile_picture)
    end
  
    def require_login
      redirect_to login_path unless current_user
    end
  end
  