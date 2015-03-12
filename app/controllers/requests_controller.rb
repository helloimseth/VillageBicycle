class RequestsController < ApplicationController
  def create
    request = current_user.requests.new(request_params)
    fail

    redirect_to bike_url(params[:id])
  end

  private

    def request_params
      params.require(:request).permit(:bike_id, :start_date, :start_time,
                                      :end_date, :end_time)
    end


end
