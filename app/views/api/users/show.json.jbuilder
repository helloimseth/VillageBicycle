json.partial! 'user', user: @user

json.bikes @user.bikes.each do |bike|
  json.partial! 'api/bikes/bike', bike: bike
end

if @user.id == current_user.id
  json.pending_requests @user.pending_requests_for do |request|
    json.partial! 'api/requests/request', request: request
  end

  json.approved_requests @user.approved_requests do |request|
    json.partial! 'api/requests/request', request: request
  end

  json.requests_made @user.pending_requests_made do |request|
    json.partial! 'api/requests/request', request: request
  end

  json.confirmed_requests @user.reservations do |request|
    json.partial! 'api/requests/request', request: request
  end
end
