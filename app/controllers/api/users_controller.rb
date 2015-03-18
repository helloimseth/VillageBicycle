class Api::UsersController < ApplicationController

  def show
    @user = User.includes(
                  bikes: :owner,
                  requests_made: :bike,
                  requests_for: [:requestor, :bike]
                 )
                .find(params[:id])

    if @user
      render :show
    else
      render json: ["Sorry that user ain't real"], status: 422
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  private

      def user_params
        params.require(:user).permit(:email, :password, :fname, :lname, :bio,
                                     :address, :neighborhood_id, :size_id,
                                     :password_confirmation, :picture)
      end

end
