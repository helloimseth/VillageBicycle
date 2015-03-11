class BikesController < ApplicationController
  before_action :require_logged_in

  def new
    @bike = Bike.new
    set_categories
    set_sizes
    set_extras
  end

  def create
    @bike = current_user.bikes.new(bike_params)

    if @bike.save
      redirect_to user_url(current_user)
    else
      flash[:notice] = @bike.errors.full_messages

      render :new
    end
  end

  def show
    @bike = Bike.find(params[:id])
  end

  def edit
    @bike = Bike.find(params[:id])
    set_categories
    set_sizes
    set_extras
  end

  def update
    @bike = Bike.find(params[:id])

    if @bike.update(bike_params)
      redirect_to bike_url(@bike)
    else
      flash[:notice] = @bike.errors.full_messages

      render :edit
    end
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.destroy!
    redirect_to user_url(current_user)
  end

  private
    def bike_params
      params.require(:bike).permit(:name, :notes, :gender, :size_id, :num_gears,
                                   :hourly_price, :category_id, extra_ids: [])
    end

end
