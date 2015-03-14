class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                     params[:user][:password])
    if @user && @user.activated
      log_in @user

      redirect_to root_url
    else
      alert = "Sorry, you haven't activated your account yet. We
               sent your activatition link to your email address"
      flash[:notice] = alert unless @user.nil?

      render :new
    end
  end

  def destroy
    log_out!

    redirect_to new_sessions_url
  end
end
