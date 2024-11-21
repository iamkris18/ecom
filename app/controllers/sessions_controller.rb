class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(email: params[:email])
        if user.nil?
            redirect_to login_path, notice: 'Invalid email or password'

        end
        unless user.nil?
        if (user.password == params[:password])
            session[:user_id] = user.id
            redirect_to profile_path, notice: 'Logged in successfully!'
        else
            redirect_to login_path, notice: 'Invalid email or password'
        end
    end
    end
    
    def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out successfully!'
    end

    def update_email
        @user = current_user
    
        if @user.update(email_params)
          redirect_to profile_path, notice: 'Email updated successfully!'
        else
          flash[:alert] = 'There was an error updating your email.'
          render :profile
        end
      end


      def email_params
        params.require(:user).permit(:email)
      end

      def update_profile
        @user = current_user
    
        # Update both email and profile_picture (if present)
        if @user.update(user_params)
          redirect_to profile_path, notice: 'Profile updated successfully!'
        else
          flash[:alert] = 'There was an error updating your profile.'
          render :profile
        end
      end
    
    
      def user_params
        params.require(:user).permit(:email, :profile_picture)
      end

end
