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
                user.user_activities.create(action: 'login', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
                session[:user]=user
                session[:user_id] = user.id
                redirect_to profile_path, notice: 'Logged in successfully!'
            else
                redirect_to login_path, notice: 'Invalid email or password'
            end
        end
    end
    
    def destroy
        user=User.find(session[:user_id])
        user.user_activities.create(action: 'logout', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
        session[:user_id] = nil

        redirect_to login_path, notice: 'Logged out successfully!'
    end

    def update_email
        @user = current_user
    
        if @user.update(email_params)
          @user.user_activities.create(action: 'updated profile', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })
          redirect_to profile_path, notice: 'Email updated successfully!'
        else
          flash[:alert] = 'There was an error updating your email.'
          render :profile
        end
      end

    def update_profile
        @user = current_user

        if @user.update(user_params)
            @user.user_activities.create(action: 'updated profile', performed_at: Time.current, metadata: { ip_address: request.remote_ip, device: 'desktop' })

            redirect_to profile_path, notice: 'Profile updated successfully!'
        else
            flash[:alert] = 'There was an error updating your profile.'
            render :profile
        end
    end

    
    def user_params
        params.require(:user).permit(:email, :profile_picture)
    end

    def email_params
        params.require(:user).permit(:email)
    end
    
end
