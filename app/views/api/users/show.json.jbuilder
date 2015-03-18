json.partial! 'user', user: @user

json.bikes @user.bikes.each do |bike|
  json.partial! 'api/bikes/bike', bike: bike
end

if @user.id == current_user.id
  json.pending_requests @user.pending_requests_for do |request|
    json.extract! request, :id, :requestor_id
    json.bike_name request.bike.name
    json.bike_type request.bike.type
    json.requestor_name request.requestor.name
  end

  json.approved_requests @user.approved_requests do |request|
    json.extract! request, :id, :requestor_id
    json.bike_name request.bike.name
    json.bike_type request.bike.type
    json.requestor_name request.requestor.name
  end

  json.requests_made @user.pending_requests_made do |request|
    json.extract! request, :id, :requestor_id
    json.bike_name request.bike.name
    json.bike_type request.bike.type
  end

  json.confirmed_requests @user.reservations do |request|
    json.extract! request, :id, :requestor_id
    json.bike_name request.bike.name
    json.bike_type request.bike.type
  end
end
