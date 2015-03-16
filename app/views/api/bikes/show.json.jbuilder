json.partial! 'bike', bike: @bike

json.owner do
  json.partial! 'api/users/user', user: @bike.owner
end
