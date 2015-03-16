json.partial! 'user', user: @user

json.bikes @user.bikes.each do |bike|
  json.partial! 'bikes/bike', bike: bike
end
