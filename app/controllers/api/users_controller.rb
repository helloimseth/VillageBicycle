class Api::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])

    if @user
      render :show
    else
      render json: ["Sorry that user ain't real"], status: 422
    end
  end

end
