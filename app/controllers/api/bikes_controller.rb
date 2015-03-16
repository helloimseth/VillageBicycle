class Api::BikesController < ApplicationController

  def show
    @bike = Bike.find(params[:id])

    if @bike
      render :show
    else
      render json: ["Sorry that bike ain't real"], status: 422
    end

  end

  def update
    @bike = Bike.find(params[:id])

    if @bike.update(bike_params)
      render :show
    else
      flash[:notice] = @bike.errors.full_messages

      render :show, status: 422
    end
  end

  def destroy
    @bike = Bike.find(params[:id])

    @bike.destroy!
  end

  private

  def bike_params
    params.require(:bike).permit(:name, :notes, :gender, :size_id, :num_gears,
                                 :hourly_price, :category_id, :picture,
                                 extra_ids: [])
  end

end
