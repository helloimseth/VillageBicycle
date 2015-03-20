class Api::BikesController < ApplicationController

  def search

    if params[:query]
      page = params[:page].nil? ? 1 : params[:page]

      @bikes = Bike.includes(:owner)
                   .search(params[:query])
                   .page(page)
                   .per(10)

    else
      @bikes = []
    end
  end

  def create
    @bike = current_user.bikes.new(bike_params)

    if @bike.save
      render :show
    else
      render json: @bike.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @bike = Bike.includes(:owner).find(params[:id])

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
    render :show
  end

  private

  def bike_params
    params.require(:bike).permit(:name, :notes, :gender, :size_id, :num_gears,
                                 :hourly_price, :category_id, :picture,
                                 extra_ids: [])
  end

end
