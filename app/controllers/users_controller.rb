class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]

  def new
    redirect_to edit_user_url(current_user) if logged_in?
    @user = User.new
    set_sizes
    set_neighborhoods
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "We've sent an activation email to your account. Please
                        click the link in the body of the email to activate
                        your account."

      msg = UserMailer.activation_email(@user)
      msg.deliver_now

      redirect_to new_user_url
    else
      flash[:notice] = @user.errors.full_messages

      render :new
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.toggle(:activated)
    log_in(@user)

    flash[:notice] = "Welcome, #{@user.fname}"

    redirect_to user_url(@user)
  end

  def show
    @user = User.find(params[:id])
    @bikes = @user.bikes
  end

  def edit
    @user = User.find(params[:id])

    if @user == current_user
      set_sizes
      set_neighborhoods

      render :edit
    else
      render :show
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user.id)
    else
      flash[:notice] = @user.errors.full_messages

      render :edit
    end
  end

  private

      def user_params
        params.require(:user).permit(:email, :password, :fname, :lname, :bio,
                                     :address, :neighborhood_id, :size_id,
                                     :password_confirmation)
      end
end
