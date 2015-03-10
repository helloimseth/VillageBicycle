class UsersController < ApplicationController

  def new
    @user = User.new

    redirect_to new_user_url
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)

      redirect_to user_url(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    redirect_to user_url(@user.id)
  end

  private

      def user_params
        params.require(:user).permit(:email, :password, :fname, :lname, :bio,
                                     :street_number, :street)
      end
end
