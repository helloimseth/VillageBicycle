class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show]

  def new
    redirect_to edit_user_url(current_user) if logged_in?
    @user = User.new
  end

  def create
    render :new unless confirmed_password?

    @user = User.new(user_params)

    if @user.save
      log_in(@user)

      # set_neighborhood_and_size_user_id

      redirect_to user_url(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    if @user == current_user
      render :edit
    else
      render :show
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)

      # set_neighborhood_and_size_user_id

      redirect_to user_url(@user.id)
    else
      render :edit
    end
  end

  private

      def user_params
        params.require(:user).permit(:email, :password, :fname, :lname, :bio,
                                     :street_number, :street, :neighborhood_id,
                                     :size_id)
      end

      def confirmed_password?
        params[:user][:password] == params[:user][:confirm_password]
      end
      #
      # def set_neighborhood_and_size_user_id
      #   Neighborhood.find(params[:users][:neighborhood_id])
      # end
end
