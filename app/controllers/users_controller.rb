class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]

  def new
    redirect_to edit_user_url(current_user) if logged_in?
    @user = User.new
    @sizes = Size.all
    @neighborhoods = Neighborhood.all
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

    redirect_to root_url
  end

  def show
    id = params[:id] || current_user.id
    @user = User.find(id)
    @bikes = @user.bikes
    @pending_requests = @user.pending_requests_for
    @approved_requests = @user.approved_requests
    @requests_made = @user.pending_requests_made
    @reservations = @user.reservations
  end

  def edit
    @user = User.find(params[:id])

    if @user == current_user
      @sizes = Size.all
      @neighborhoods = Neighborhood.all

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
      @sizes = Size.all
      @neighborhoods = Neighborhood.all

      render :edit
    end
  end

  private

      def user_params
        params.require(:user).permit(:email, :password, :fname, :lname, :bio,
                                     :address, :neighborhood_id, :size_id,
                                     :password_confirmation, :picture, :provider,
                                     :uid)
      end
end
