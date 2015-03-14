class Api::BikesController < ApplicationController

  def show
    @bike = Bike.find(params[:id])

    if @bike
      render :show
    else
      render json: ["Sorry that bike ain't real"], status: 422
    end

  end

end
