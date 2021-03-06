class BikesController < ApplicationController
  before_action :require_logged_in

  def new
    @bike = Bike.new
    @categories = Category.all
    @sizes = Size.all
    @extras = Extra.all
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
    @categories = Category.all
    @sizes = Size.all
    @extras = Extra.all
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

  def search
    @categories = Category.all
    @sizes = Size.all
    @neighborhoods = Neighborhood.all

    if params[:query]
      @bikes = Bike.search(params[:query])
      @search_query = Bike.maps_search_query(@bikes)
    else
      @bikes = []
    end

  end

  private
    def bike_params
      params.require(:bike).permit(:name, :notes, :gender, :size_id, :num_gears,
                                   :hourly_price, :category_id, :picture,
                                   extra_ids: [])
    end

end
