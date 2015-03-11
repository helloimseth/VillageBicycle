class BikesController < ApplicationController
  def index
    @bikes = Bike.find_by(owner_id: params[:user_id])
  end
end
