json.partial! 'user', user: @user

json.bikes @user.bikes.each do |bike|
  json.partial! 'api/bikes/bike', bike: bike
end
