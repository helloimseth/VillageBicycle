class Api::RequestsController < ApplicationController
  def create
    @request = current_user.requests_made.new(request_params)

    if @request.save
      flash[:notice] = "Thank you for requesting #{@request.bike.name} the
                        #{@request.bike.type}! #{@request.bike.name}'s owner is
                        reviewing your request and we'll notify you when they've
                        responded."

      render json: @request
    else
      render json: @request.errors.full_messages
    end
  end

  def approve
    request = Request.find(params[:id])
    request.approve!

    flash[:notice] = "Awesome! #{request.requestor.name} will rent
                      #{request.bike.name} from #{request.start.to_formatted_s(:short)}
                      to #{request.end.to_formatted_s(:short)}"

    render json: @request
  end

  def reject
    request = Request.find(params[:id])
    request.reject!

    render json: @request
  end

  private

    def request_params
      params.require(:request).permit(:bike_id, :start, :end)
    end

end
