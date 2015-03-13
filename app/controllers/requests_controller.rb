class RequestsController < ApplicationController
  def create
    @request = current_user.requests_made.new(request_params)

    if @request.save
      flash[:notice] = "Thank you for requesting #{@request.bike.name} the
                        #{@request.bike.type}! #{@request.bike.name}'s owner is
                        reviewing your request and we'll notify you when they've
                        responded."

      redirect_to user_url(current_user)
    else
      flash[:request_error] = @request.errors.full_messages

      redirect_to bike_url(@request.bike_id)
    end
  end

  private

    def request_params
      params.require(:request).permit(:bike_id, :start, :end)
    end

end
