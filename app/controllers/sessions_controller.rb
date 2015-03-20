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

  def omniauth
    @user = User.find_by_auth_hash(auth_hash)

    if user
      log_in(@user)
      redirect_to root_url
    else
      @user = User.new
      @sizes = Size.all
      @neighborhoods = Neighborhood.all

      @uid = auth_hash[:uid]
      @provider = auth_hash[:provider]

      render 'users/new_from_twitter'
    end
  end

  def demo_sign_in
    @user = User.find_by(email: 'email@example.com')
    log_in(@user)
    redirect_to root_url
  end

  def destroy
    log_out!

    redirect_to new_sessions_url
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end
end
